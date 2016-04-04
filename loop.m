function [t,x] = loop(u1_sw_vec, u2_sw_vec, tfinal, x0, h)
    
    %default h - liczba krok�w na sekund�
    if(nargin < 5)
        h = 100;
    end
    %u1_sw_vec/u2_sw_vec - czasy prze��cze� sterowa�
    %tfinal - ko�cowy czas symulacji
    u1min = 3;
    u1max = 35;
    u2min = 0;
    u2max = 900;
    u1 = u1min;                    %warto�� pocz�tkowa sterowania 1
    u2 = u2min;                    %warto�� pocz�tkowa sterowania 2

    x = [];
    t0 = 0;
    t = [];
    u1_idx = 1;
    u2_idx = 1;
    
    %potrzebne do warunku petli
    u1_sw_vec = [u1_sw_vec ; tfinal];
    u2_sw_vec = [u2_sw_vec ; tfinal];
    
    while (u1_idx<=length(u1_sw_vec) || u2_idx<=length(u2_sw_vec))
        tf = u1_sw_vec(u1_idx)*(u1_sw_vec(u1_idx)<=u2_sw_vec(u2_idx)) + u2_sw_vec(u2_idx)*(u1_sw_vec(u1_idx)>u2_sw_vec(u2_idx));
        u = [u1*ones(h*(tf-t0),1) u2*ones(h*(tf-t0),1)];
        [t_tmp, x_tmp] = rk4(x0,u,tf - t0);
        
        x = [x; x_tmp(2:end,:)];
        if(~isempty(t) > 0)
            t = [t; t_tmp(2:end) + t(end)];
        else 
            t = [t;t_tmp(2:end)];
        end
        
        x0 = x(end,:)'
        t0 = tf;
                
        if(u1_sw_vec(u1_idx)<u2_sw_vec(u2_idx))
            u1 = u1min*(u1 == u1max) + u1max*(u1 == u1min);
            u1_idx = u1_idx + 1;
        elseif(u1_sw_vec(u1_idx)>u2_sw_vec(u2_idx))
            u2 = u2min*(u2 == u2max) + u2max*(u2 == u2min);
            u2_idx = u2_idx + 1;
        else
            u1 = u1min*(u1 == u1max) + u1max*(u1 == u1min);
            u2 = u2min*(u2 == u2max) + u2max*(u2 == u2min);
            u1_idx = u1_idx + 1;
            u2_idx = u2_idx + 1;
        end
        if(u1_idx > length(u1_sw_vec))
            break;
        end        
    end
end