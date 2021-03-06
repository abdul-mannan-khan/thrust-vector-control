function Fv = F_1(t,zeta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Fv = F_1(jd,zeta) - flow map for the hybrid system H_1
%  
%  jd - reference jerk
%  zeta = (z,R,y)
%  Fv - 21d vector
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    global P bark1 g k1 lambda1
    [~,~,~,jd] = circle(t);
    z  = zeta(1:9);
    ad = z(1:3);
    pe = z(4:6);
    ve = z(7:9);
    R  = reshape(zeta(10:18),[3 3]);
    y  = zeta(19:21);
    dR = R*S(kappa_1(jd,zeta));
    Fv = [Fp(jd,zeta);dR(:);zeros(3,1)];
    % derivative of the Lyapunov function
    Vpv   = Vp(pe,ve);
    Vxy   = V(R'*rho(z),y);
    wv    = w(pe,ve);
    dW_dt = [pe' ve']*P*[ve;wv]/sqrt(Vpv)-0.5*bark1*lambda1*sqrt(Vxy)*(k1);
    Fv = [Fv;dW_dt];