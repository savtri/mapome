function [ C1111 ] = C1111TermDamageElastTangent( g,l,m,E,v,e11,e12,e22,icase )
%% C1111
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
	t21 = t8 * e12;
	t23 = t13 ^ 2 / 0.4e1;
	t24 = t23 ^ 2;
	t26 = 0.1e1 / t24 * t21 / t19;
	t27 = e22 + e11 + t12;
	t28 = 0.0e0 < t27 / 0.2e1;
	t29 = t27 / 0.2e1 <= 0.0e0;
	t30 = piecewiseFun(t28, t27 / 0.2e1, t29, 0);
	t32 = absDerFun(1, t15);
	t36 = (e11 - e22) / t12 / 0.2e1;
	t37 = -0.1e1 / 0.2e1 + t36;
	t38 = t37 * t32;
	t43 = t8 / t18;
	t46 = 0.2e1 / t23 / t13;
	t51 = 0.1e1 / t23;
	t52 = 0.1e1 / 0.2e1 + t36;
	t53 = piecewiseFun(t28, t52, t29, 0);
	t56 = e22 - e11 - t12;
	t58 = 0.2e1 / t56 * e12;
	t59 = abs(t58);
	t60 = t59 ^ 2;
	t61 = 0.1e1 + t60;
	t62 = t61 ^ 2;
	t65 = t56 ^ 2 / 0.4e1;
	t66 = t65 ^ 2;
	t68 = 0.1e1 / t66 * t21 / t62;
	t69 = e22 + e11 - t12;
	t70 = 0.0e0 < t69 / 0.2e1;
	t71 = t69 / 0.2e1 <= 0.0e0;
	t72 = piecewiseFun(t70, t69 / 0.2e1, t71, 0);
	t74 = absDerFun(1, t58);
	t75 = -t52 * t74;
	t80 = t8 / t61;
	t83 = 0.2e1 / t65 / t56;
	t88 = 0.1e1 / t65;
	t89 = piecewiseFun(t70, -t37, t71, 0);
	t99 = e22 / 0.2e1;
	t100 = e11 / 0.2e1;
	t101 = t12 / 0.2e1;
	t102 = t99 + t100 + t101 - t30;
	t114 = t99 + t100 - t101 - t72;    
    C1111 = (((1 + t2) * l) / 0.2e1 + 0.2e1 * (0.2e1 * t38 * t16 * t30 * t26 - 0.2e1 * t37 * t30 * t46 * t43 + t53 * t51 * t43 + 0.2e1 * t75 * t59 * t72 * t68 + 0.2e1 * t52 * t72 * t83 * t80 + t89 * t88 * t80) * m) * g + ((1 - t2) * l) / 0.2e1 + 0.2e1 * (0.2e1 * t38 * t16 * t102 * t26 - 0.2e1 * t37 * t102 * t46 * t43 + (0.1e1 / 0.2e1 + t36 - t53) * t51 * t43 + 0.2e1 * t75 * t59 * t114 * t68 + 0.2e1 * t52 * t114 * t83 * t80 + (0.1e1 / 0.2e1 - t36 - t89) * t88 * t80) * m;
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
t28 = t15 * e12;
t30 = t20 ^ 2 / 0.4e1;
t31 = t30 ^ 2;
t33 = 0.1e1 / t31 * t28 / t26;
t34 = e22 + e11 + t19;
t35 = 0.0e0 < t34 / 0.2e1;
t36 = piecewiseFun2(t35, t34 / 0.2e1);
t38 = absDerFun(1, t22);
t42 = (e11 - e22) / t19 / 0.2e1;
t43 = -0.1e1 / 0.2e1 + t42;
t44 = t43 * t38;
t49 = t15 / t25;
t52 = 0.2e1 / t30 / t20;
t57 = 0.1e1 / t30;
t58 = 0.1e1 / 0.2e1 + t42;
t59 = piecewiseFun2(t35, t58);
t62 = e22 - e11 - t19;
t64 = 0.2e1 / t62 * e12;
t65 = abs(t64);
t66 = t65 ^ 2;
t67 = 0.1e1 + t66;
t68 = t67 ^ 2;
t71 = t62 ^ 2 / 0.4e1;
t72 = t71 ^ 2;
t74 = 0.1e1 / t72 * t28 / t68;
t75 = e22 + e11 - t19;
t76 = 0.0e0 < t75 / 0.2e1;
t77 = piecewiseFun2(t76, t75 / 0.2e1);
t79 = absDerFun(1, t64);
t80 = -t58 * t79;
t85 = t15 / t67;
t88 = 0.2e1 / t71 / t62;
t93 = 0.1e1 / t71;
t94 = piecewiseFun2(t76, -t43);
t104 = e22 / 0.2e1;
t105 = e11 / 0.2e1;
t106 = t19 / 0.2e1;
t107 = t104 + t105 + t106 - t36;
t119 = t104 + t105 - t106 - t77;
C1111 = (((1 - t3 + t9) * l) / 0.2e1 + 0.2e1 * (0.2e1 * t44 * t23 * t36 * t33 - 0.2e1 * t43 * t36 * t52 * t49 + t59 * t57 * t49 + 0.2e1 * t80 * t65 * t77 * t74 + 0.2e1 * t58 * t77 * t88 * t85 + t94 * t93 * t85) * m) * g + ((1 - t3 - t9) * l) / 0.2e1 + 0.2e1 * (0.2e1 * t44 * t23 * t107 * t33 - 0.2e1 * t43 * t107 * t52 * t49 + (0.1e1 / 0.2e1 + t42 - t59) * t57 * t49 + 0.2e1 * t80 * t65 * t119 * t74 + 0.2e1 * t58 * t119 * t88 * t85 + (0.1e1 / 0.2e1 - t42 - t94) * t93 * t85) * m;

end
end
