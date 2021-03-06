function [ C2222 ] = C2222TermDamageElastTangent( g,l,m,E,v,e11,e12,e22,icase )
%% C2222
if icase==1
t2 = absDerFun(1, e22 + e11);
t5 = (e11 ^ 2);
t8 = (e12 ^ 2);
t10 = (e22 ^ 2);
t12 = sqrt((-2 * e22 * e11 + t10 + t5 + 4 * t8));
t13 = e22 - e11 + t12;
t15 = 0.2e1 / t13 * e12;
t16 = abs(t15);
t17 = t16 ^ 2;
t18 = 0.1e1 + t17;
t19 = t18 ^ 2;
t20 = 0.1e1 / t19;
t21 = e22 + e11 + t12;
t22 = 0.0e0 < t21 / 0.2e1;
t23 = t21 / 0.2e1 <= 0.0e0;
t24 = piecewiseFun(t22, t21 / 0.2e1, t23, 0);
t27 = absDerFun(1, t15);
t34 = (-e11 + e22) / t12 / 0.2e1;
t35 = 0.1e1 / 0.2e1 + t34;
t37 = 0.4e1 * t35 / t13 ^ 2 * e12 * t27;
t40 = 0.1e1 / t18;
t41 = piecewiseFun(t22, t35, t23, 0);
t43 = e22 - e11 - t12;
t45 = 0.2e1 / t43 * e12;
t46 = abs(t45);
t47 = t46 ^ 2;
t48 = 0.1e1 + t47;
t49 = t48 ^ 2;
t50 = 0.1e1 / t49;
t51 = e22 + e11 - t12;
t52 = 0.0e0 < t51 / 0.2e1;
t53 = t51 / 0.2e1 <= 0.0e0;
t54 = piecewiseFun(t52, t51 / 0.2e1, t53, 0);
t57 = absDerFun(1, t45);
t61 = 0.1e1 / 0.2e1 - t34;
t63 = 0.4e1 * t61 / t43 ^ 2 * e12 * t57;
t66 = 0.1e1 / t48;
t67 = piecewiseFun(t52, t61, t53, 0);
t76 = e22 / 0.2e1;
t77 = e11 / 0.2e1;
t78 = t12 / 0.2e1;
C2222 = (((1 + t2) * l) / 0.2e1 + 0.2e1 * (0.2e1 * t37 * t16 * t24 * t20 + t41 * t40 + 0.2e1 * t63 * t46 * t54 * t50 + t67 * t66) * m) * g + ((1 - t2) * l) / 0.2e1 + 0.2e1 * (0.2e1 * t37 * t16 * (t76 + t77 + t78 - t24) * t20 + (0.1e1 / 0.2e1 + t34 - t41) * t40 + 0.2e1 * t63 * t46 * (t76 + t77 - t78 - t54) * t50 + (0.1e1 / 0.2e1 - t34 - t67) * t66) * m;
elseif icase==2
t3 = v / (1 - v);
t7 = absDerFun(1, e11 + e22 - (e11 + e22) * t3);
t9 = (1 - t3) * t7;
t12 = e11 ^ 2;
t15 = (e12 ^ 2);
t17 = e22 ^ 2;
t19 = sqrt((-2 * e22 * e11 + t12 + 4 * t15 + t17));
t20 = e22 - e11 + t19;
t22 = 0.2e1 / t20 * e12;
t23 = abs(t22);
t24 = t23 ^ 2;
t25 = 0.1e1 + t24;
t26 = t25 ^ 2;
t27 = 0.1e1 / t26;
t28 = e22 + e11 + t19;
t29 = 0.0e0 < t28 / 0.2e1;
t30 = piecewiseFun2(t29, t28 / 0.2e1);
t33 = absDerFun(1, t22);
t40 = (-e11 + e22) / t19 / 0.2e1;
t41 = 0.1e1 / 0.2e1 + t40;
t43 = 0.4e1 * t41 / t20 ^ 2 * e12 * t33;
t46 = 0.1e1 / t25;
t47 = piecewiseFun2(t29, t41);
t49 = e22 - e11 - t19;
t51 = 0.2e1 / t49 * e12;
t52 = abs(t51);
t53 = t52 ^ 2;
t54 = 0.1e1 + t53;
t55 = t54 ^ 2;
t56 = 0.1e1 / t55;
t57 = e22 + e11 - t19;
t58 = 0.0e0 < t57 / 0.2e1;
t59 = piecewiseFun2(t58, t57 / 0.2e1);
t62 = absDerFun(1, t51);
t66 = 0.1e1 / 0.2e1 - t40;
t68 = 0.4e1 * t66 / t49 ^ 2 * e12 * t62;
t71 = 0.1e1 / t54;
t72 = piecewiseFun2(t58, t66);
t81 = e22 / 0.2e1;
t82 = e11 / 0.2e1;
t83 = t19 / 0.2e1;
C2222 = (((1 - t3 + t9) * l) / 0.2e1 + 0.2e1 * (0.2e1 * t43 * t23 * t30 * t27 + t47 * t46 + 0.2e1 * t68 * t52 * t59 * t56 + t72 * t71) * m) * g + ((1 - t3 - t9) * l) / 0.2e1 + 0.2e1 * (0.2e1 * t43 * t23 * (t81 + t82 + t83 - t30) * t27 + (0.1e1 / 0.2e1 + t40 - t47) * t46 + 0.2e1 * t68 * t52 * (t81 + t82 - t83 - t59) * t56 + (0.1e1 / 0.2e1 - t40 - t72) * t71) * m;
    
    
end

end

