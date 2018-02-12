%% MAP P(e)
% Case 1

TA = 0;
FB = 0;

TB = 0;
FA = 0;

for i=1:length(A)
    pos = A(i);
    MAP_AB = getMAPClass(pos, mu_C, cov_C, P_A, mu_D, cov_D, P_B);

    if MAP_AB == 1
        TA = TA + 1;
    else
        FB = FB + 1;
    end
end

for i=1:length(B)
    pos = B(i);
    MAP_AB = getMAPClass(pos, mu_C, cov_C, P_A, mu_D, cov_D, P_B);

    if MAP_AB == 2
        TB = TB + 1;
    else
        FA = FA + 1;
    end
end

matrix_ab = [
    [TA, FB];
    [FA, TB];
];

disp('Confusion Matrix (A,B)');
disp(matrix_ab);

case_1_correct = (TA+TB) / (400);
case_1_P_error = 1 - case_1_correct;

disp('P(error)');
disp(case_1_P_error);

%% Case 2

TC = 0;
C_FD = 0;
C_FE = 0;

TD = 0;
D_FC = 0;
D_FE = 0;

TE = 0;
E_FC = 0;
E_FD = 0;

for i=1:length(C)
    pos = C(i);
    MAP_CD = getMAPClass(pos, mu_C, cov_C, P_C, mu_D, cov_D, P_D);
    MAP_CE = getMAPClass(pos, mu_C, cov_C, P_C, mu_E, cov_E, P_E);
    MAP_DE = getMAPClass(pos, mu_D, cov_D, P_D, mu_E, cov_E, P_E);

    if MAP_CD == 1 && MAP_CE == 1
        TC = TC + 1;
    elseif MAP_DE == 1
        C_FD = C_FD + 1;
    elseif MAP_DE == 2
        C_FE = C_FE + 1;
    end
end

for i=1:length(D)
    pos = D(i);
    MAP_CD = getMAPClass(pos, mu_C, cov_C, P_C, mu_D, cov_D, P_D);
    MAP_CE = getMAPClass(pos, mu_C, cov_C, P_C, mu_E, cov_E, P_E);
    MAP_DE = getMAPClass(pos, mu_D, cov_D, P_D, mu_E, cov_E, P_E);

    if MAP_CD == 2 && MAP_DE == 1
        TD = TD + 1;
    elseif MAP_CE == 1
        D_FC = D_FC + 1;
    elseif MAP_CE == 2
        D_FE = D_FE + 1;
    end
end

for i=1:length(E)
    pos = E(i);
    MAP_CD = getMAPClass(pos, mu_C, cov_C, P_C, mu_D, cov_D, P_D);
    MAP_CE = getMAPClass(pos, mu_C, cov_C, P_C, mu_E, cov_E, P_E);
    MAP_DE = getMAPClass(pos, mu_D, cov_D, P_D, mu_E, cov_E, P_E);

    if MAP_DE == 2 && MAP_CE == 2
        TE = TE + 1;
    elseif MAP_CD == 1
        E_FC = E_FC + 1;
    elseif MAP_CD == 2
        E_FD = E_FD + 1;
    end
end

matrix_cde = [
    [TC, C_FD, C_FE];
    [D_FC, TD, D_FE];
    [E_FC, E_FD, TE];
];

disp('Confusion Matrix (C,D,E)');
disp(matrix_cde);

case_2_correct = (TC + TE + TD) / (450);
case_2_P_error = 1 - case_2_correct;

disp('P(error)');
disp(case_2_P_error);
