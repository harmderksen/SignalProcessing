% function [g,node_x,node_y,signature] = TautString(z_up,z_down)
%
% The Taut String Algorithm
%
% input: 
% z_up: upper bound
% z_down: lower bound
% 
% output:
% g: denoised signal
% node_x: x-coordinates of nodes
% node_y: y-coordinates of nodes
% signature: vector of +/- 1's, +1 means "bends up at node", "-1" means
% bends down

function [g,node_x,node_y,signature] = TautString(z_up,z_down)
eps=10^(-10);
n=length(z_up);
bound_up=zeros(1,n);
bound_down=zeros(1,n);
joint_up=zeros(1,n);
joint_down=zeros(1,n);
sign_vec=zeros(1,n);
k_up=1;
k_down=1;
bound_up(1)=z_up(1);
bound_down(1)=z_down(1);
joint_up(1)=1;
joint_down(1)=1;
j=0;
for i=2:n+1
    while k_up>j
        if i==n+1
            slope_right=0;
        else
            slope_right=(z_up(i)-bound_up(k_up))/(i-joint_up(k_up));
        end
        if k_up==1
            slope_left=0;
        else
            slope_left=(bound_up(k_up)-bound_up(k_up-1))/(joint_up(k_up)-joint_up(k_up-1));
        end
        if slope_right>slope_left+eps
            break;
        end
        k_up=k_up-1;
    end
    k_up=k_up+1;
    joint_up(k_up)=min(i,n);
    bound_up(k_up)=z_up(min(i,n));
    while k_down>j 
        if i==n+1 
            slope_right=0;
        else
            slope_right=(z_down(i)-bound_down(k_down))/(i-joint_down(k_down));
        end
        if k_down==1 
            slope_left=0;
        else
            slope_left=(bound_down(k_down)-bound_down(k_down-1))/(joint_down(k_down)-joint_down(k_down-1));
        end
        if slope_right<slope_left-eps
            break
        end
        k_down=k_down-1;
    end
    k_down=k_down+1;
    joint_down(k_down)=min(i,n);
    bound_down(k_down)=z_down(min(i,n));
    while j<k_down-1 
        if i<=n
            slope_right=(z_up(i)-bound_down(j+1))/(i-joint_down(j+1));
        else
            slope_right=0;
        end
        if j>0
            slope_left=(bound_down(j+1)-bound_down(j))/(joint_down(j+1)-joint_down(j));
        else
            slope_left=0;
        end
        if slope_right>slope_left
            break;
        end
        j=j+1;
        bound_up(j)=bound_down(j);
        joint_up(j)=joint_down(j);
        sign_vec(j)=-1;
        k_up=k_up+1;
        bound_up(k_up)=z_up(min(i,n));
        joint_up(k_up)=min(i,n);
    end
    while j< k_up-1
        if i<=n
            slope_right=(z_down(i)-bound_up(j+1))/(i-joint_up(j+1));
        else
            slope_right=0;
        end
        if j>0
            slope_left=(bound_up(j+1)-bound_up(j))/(joint_up(j+1)-joint_up(j));
        else
            slope_left=0;
        end
        if slope_right<slope_left
            break
        end
        j=j+1;
        bound_down(j)=bound_up(j);
        joint_down(j)=joint_up(j);
        sign_vec(j)=1;
        k_down=k_down+1;
        bound_down(k_down)=z_down(min(i,n)); 
        joint_down(k_down)=min(i,n);
    end
end
node_x=joint_up(1:j);
node_y=bound_up(1:j);
signature=sign_vec(1:j);
g=ones(1,n)*max(z_down);
if length(node_x)>0
    m=length(node_x);
    g(1:node_x(1))=node_y(1)*ones(node_x(1),1);
    for i=1:m-1
        s=node_x(i);
        t=node_x(i+1);
        for j=s+1:t
            g(j)=(t-j)/(t-s)*node_y(i)+(j-s)/(t-s)*node_y(i+1);
        end
    end
    g(node_x(m):n)=node_y(m)*ones(n-node_x(m)+1,1);
end

end

