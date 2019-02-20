function [ Dmatx ] = DamagePlaneStress( j,i,iid,l,mu,E,v,kPF,Mp,InputIndex )
%% Degradation function
c=Mp.c(1,iid); %Phase Field value in GPs
g=(1-kPF)*c^2+kPF; %Degradation function

%% Define strain terms
e11=Mp.e(1,iid);
e22=Mp.e(2,iid);
e12=Mp.e(3,iid)/2;

%% Check for zero strains for replace with 0.1e-14
[ e11,e22,e12 ] = CheckForZeroStrains( e11,e22,e12 ); 

%% C1111
[ C1111 ] = C1111TermDamageElastTangent( g,l,mu,E,v,e11,e12,e22,2 );
%% C1122
[ C1122 ] = C1122TermDamageElastTangent( g,l,mu,E,v,e11,e12,e22,2 );
%% C1112
[ C1112 ] = C1112TermDamageElastTangent( g,l,mu,E,v,e11,e12,e22,2 );
%% C2211
[ C2211 ] = C2211TermDamageElastTangent( g,l,mu,E,v,e11,e12,e22,2 );
%% C2222
[ C2222 ] = C2222TermDamageElastTangent( g,l,mu,E,v,e11,e12,e22,2 );
%% C2212
[ C2212 ] = C2212TermDamageElastTangent( g,l,mu,E,v,e11,e12,e22,2 );
%% C1211
[ C1211 ] = C1211TermDamageElastTangent( g,l,mu,E,v,e11,e12,e22,2 );
%% C1222
[ C1222 ] = C1222TermDamageElastTangent( g,l,mu,E,v,e11,e12,e22,2 );
%% C1212
[ C1212 ] = C1212TermDamageElastTangent( g,l,mu,E,v,e11,e12,e22,2 );

%% Compute the Damage Elastic Tangent Matrix
Dmatx=[C1111,C1122,C1112;
       C2211,C2222,C2212;
       C1211,C1222,C1212];
   
%% Check For NaN Values Cijkl   
if max(max(isnan(Dmatx)))==1
    %Constitutive matrix
    [ Dmatx ] = ElasticTensor( E,v,InputIndex ); 
end  
   
end

