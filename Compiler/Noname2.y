%{
	#include<stdio.h>
	int name[26];
	int x[26];
	float y[26];
	char z[26];
	char w[26][26];
	int loc[26];
	int ln[26];
	int con[3];
	int co[3];
%}

%union
{
  int in;
  float fl;
  char ch;
  char st[26];
}

%start s
%token <in> NUM ID 
%token <fl> FLO
%token <ch> CH
%token <st> CHH
%token      INT FLOAT STRING CHAR PRINT IF ELSE THEN FOR

%type  <fl> stat term fact 
%type  <in> ass lo rel init
%% 

s: f
 | s ';' f
 ;


f: stat {printf("the result = %g \n",$1);}
 | ass
 | dec
 | inde
 | pr
 | if
 | lo  {printf("the result = %d \n",$1);}
 | rel {printf("the result = %d \n",$1);}
 | for 
 ;

for: FOR '(' init ';' cond ';' count ')' '{' s '}' 
	  {int i;
	  if (con[1]==1&&co[1]==1)
	  for(i=loc[$3];loc[con[0]]>con[2];loc[co[0]]+=co[2])printf("if is excuted\n");

	  else if (con[1]==1&&co[1]==2)
	  for(i=loc[$3];loc[con[0]]>con[2];loc[co[0]]*=co[2])printf("if is excuted\n");

	  else if (con[1]==1&&co[1]==3)
	  for(i=loc[$3];loc[con[0]]>con[2];loc[co[0]]/=co[2])printf("if is excuted\n");

	  else if (con[1]==2&&co[1]==1)
	  for(i=loc[$3];loc[con[0]]<con[2];loc[co[0]]+=co[2])printf("if is excuted\n");

	  else if (con[1]==2&&co[1]==2)
	  for(i=loc[$3];loc[con[0]]<con[2];loc[co[0]]*=co[2])printf("if is excuted\n");

	  else if (con[1]==2&&co[1]==3)
	  for(i=loc[$3];loc[con[0]]<con[2];loc[co[0]]/=co[2])printf("if is excuted\n");

	  else if (con[1]==3&&co[1]==1)
	  for(i=loc[$3];loc[con[0]]<=con[2];loc[co[0]]+=co[2])printf("if is excuted\n");

	  else if (con[1]==3&&co[1]==2)
	  for(i=loc[$3];loc[con[0]]<=con[2];loc[co[0]]*=co[2])printf("if is excuted\n");

	  else if (con[1]==3&&co[1]==3)
	  for(i=loc[$3];loc[con[0]]<=con[2];loc[co[0]]/=co[2])printf("if is excuted\n");

	  else if (con[1]==4&&co[1]==1)
	  for(i=loc[$3];loc[con[0]]>=con[2];loc[co[0]]+=co[2])printf("if is excuted\n");

	  else if (con[1]==4&&co[1]==2)
	  for(i=loc[$3];loc[con[0]]>=con[2];loc[co[0]]*=co[2])printf("if is excuted\n");

	  else
	  for(i=loc[$3];loc[con[0]]>=con[2];loc[co[0]]/=co[2])printf("if is excuted\n");

	  ln[$3]=0;loc[$3]=0;}
   ;


init: INT ID '=' stat {if(ln[$2]==0){ln[$2]=1;loc[$2]=$4;$$=$2;}
		       else printf("this variable is not decleard before\n");}

    | ID '=' stat {if(name[$1]==1){ln[$1]=1;loc[$1]=$3;$$=$1;}
		   else printf("wrong variable\n");}
    ;


cond: ID '>' stat {if(name[$1]==1){ln[$1]=1;loc[$1]=x[$1];con[0]=$1;con[1]=1;con[2]=$3;}
		   else if(ln[$1]==1){con[0]=$1;con[1]=1;con[2]=$3;}
		   else printf("wrong condtion\n");}

    | ID '<' stat {if(name[$1]==1){ln[$1]=1;loc[$1]=x[$1];con[0]=$1;con[1]=2;con[2]=$3;}
		   else if(ln[$1]==1){con[0]=$1;con[1]=2;con[2]=$3;}
		   else printf("wrong condtion\n");}

    | ID '<''=' stat {if(name[$1]==1){ln[$1]=1;loc[$1]=x[$1];con[0]=$1;con[1]=3;con[2]=$4;}
		   else if(ln[$1]==1){con[0]=$1;con[1]=3;con[2]=$4;}
		   else printf("wrong condtion\n");}

    | ID '>''=' stat {if(name[$1]==1){ln[$1]=1;loc[$1]=x[$1];con[0]=$1;con[1]=4;con[2]=$4;}
		   else if(ln[$1]==1){con[0]=$1;con[1]=4;con[2]=$4;}
		   else printf("wrong condtion\n");}
    ;


count: ID '+''+' {if(name[$1]==1){ln[$1]=1;loc[$1]=x[$1];co[0]=$1;co[1]=1;co[2]=1;}
		  else if(ln[$1]==1){co[0]=$1;co[1]=1;co[2]=1;}
		  else printf("wrong counter\n");}

     | ID '-''-' {if(name[$1]==1){ln[$1]=1;loc[$1]=x[$1];co[0]=$1;co[1]=1;co[2]=-1;}
		  else if(ln[$1]==1){co[0]=$1;co[1]=1;co[2]=-1;}
		  else printf("wrong counter\n");}

     | '+''+' ID {if(name[$3]==1){ln[$3]=1;loc[$3]=x[$3];co[0]=$3;co[1]=1;co[2]=1;}
		  else if(ln[$3]==1){co[0]=$3;co[1]=1;co[2]=1;}
		  else printf("wrong counter\n");}

     | '-''-' ID {if(name[$3]==1){ln[$3]=1;loc[$3]=x[$3];co[0]=$3;co[1]=1;co[2]=-1;}
		  else if(ln[$3]==1){co[0]=$3;co[1]=1;co[2]=-1;}
		  else printf("wrong counter\n");}

     | ID '+''=' stat {if(name[$1]==1){ln[$1]=1;loc[$1]=x[$1];co[0]=$1;co[1]=1;co[2]=$4;}
		  else if(ln[$1]==1){co[0]=$1;co[1]=1;co[2]=$4;}
		  else printf("wrong counter\n");}

     | ID '-''=' stat stat {if(name[$1]==1){ln[$1]=1;loc[$1]=x[$1];co[0]=$1;co[1]=1;co[2]=-$4;}
		  else if(ln[$1]==1){co[0]=$1;co[1]=1;co[2]=-$4;}
		  else printf("wrong counter\n");}

     | ID '*''=' stat stat {if(name[$1]==1){ln[$1]=1;loc[$1]=x[$1];co[0]=$1;co[1]=2;co[2]=$4;}
		  else if(ln[$1]==1){co[0]=$1;co[1]=2;co[2]=$4;}
		  else printf("wrong counter\n");}

     | ID '/''=' stat stat {if(name[$1]==1){ln[$1]=1;loc[$1]=x[$1];co[0]=$1;co[1]=3;co[2]=$4;}
		  else if(ln[$1]==1){co[0]=$1;co[1]=3;co[2]=$4;}
		  else printf("wrong counter\n");}
     ;



if: IF '(' lo ')' THEN '{' s '}' {if($3==1)printf("if is okay\n");else printf("if is not okay\n");}
  | IF '(' lo ')' THEN '{' s '}' ELSE '{' s '}' {if($3==1)printf("if is okay\n");else printf("if is not okay\n");}
  ;


lo: rel '&' rel {$$=$1&&$3;}
  | rel '|' rel {$$=$1||$3;}
  | '!' rel     {$$=!$2;}
  | rel         {$$=$1;}
  ;


rel: stat '<' stat     {$$=$1<$3;}
    | stat '>' stat    {$$=$1>$3;}
    | stat '<''=' stat {$$=($1<=$4);}
    | stat '>''=' stat {$$=($1>=$4);}
    | stat '!''=' stat {$$=($1!=$4);}
    | stat '<''>' stat {$$=($1==$4);}
    ;


pr: PRINT '(' ID  ')' {if(name[$3]==0)printf("this variable not decleard\n");
		       else if(name[$3]==1)printf("%d \n",x[$3]);
		       else if(name[$3]==2)printf("%g \n",y[$3]);
		       else if(name[$3]==3)printf("%c \n",z[$3]);
		       else {int i;for(i=1;i<w[$3][0];i++)printf("%c",w[$3][i]);printf("\n");}}

  | PRINT '(' CHH ')' {int i;for(i=1;i<$3[0];i++)printf("%c",$3[i]);printf("\n");}
  ;



dec: INT ID {if(name[$2]==0)name[$2]=1;
	    else if(name[$2]==1)printf("decleard before\n"); 
	    else printf("decleard in diff type\n");}

   | INT ID '=' stat {if(name[$2]==0){name[$2]=1;x[$2]=$4;}
                      else if(name[$2]==1)printf("decleard before\n"); 
		      else printf("decleard in diff type\n");}

   | FLOAT ID {if(name[$2]==0)name[$2]=2;
               else if(name[$2]==2)printf("decleard before\n"); 
	       else printf("decleard in diff type\n");}

   | FLOAT ID '=' stat {if(name[$2]==0){name[$2]=2;y[$2]=$4;}
		        else if(name[$2]==2)printf("decleard before\n"); 
			else printf("decleard in diff type\n");}

   | CHAR ID {if(name[$2]==0)name[$2]=3;
	      else if(name[$2]==3)printf("decleard before\n");
	      else printf("decleard in diff type\n");}

   | CHAR ID '=' CH {if(name[$2]==0){name[$2]=3;z[$2]=$4;}
		       else if(name[$2]==3)printf("decleard before\n"); 
		       else printf("decleard in diff type\n");}

   | STRING ID {if(name[$2]==0)name[$2]=4;
		else if(name[$2]==4)printf("decleard before\n");
		else printf("decleard in diff type\n");}

   | STRING ID '=' CHH {if(name[$2]==0){name[$2]=4;int i; for(i=0;i<$4[0];i++)w[$2][i]=$4[i];}
			 else if(name[$2]==4)printf("decleard before\n"); 
			 else printf("decleard in diff type\n");}
   ;

inde: '+''+'ID {if(name[$3]==1)++x[$3];
		else if(name[$3]==2)++y[$3];
		else if(name[$3]==0)printf("this variable is not decleared before\n");
		else printf("this variable is not conpitable with operation\n");}

    | '-''-'ID {if(name[$3]==1)--x[$3];
		else if(name[$3]==2)--y[$3];
		else if(name[$3]==0)printf("this variable is not decleared before\n");
		else printf("this variable is not conpitable with operation\n");}

    | '+'ID'+' {if(name[$2]==1)x[$2]++;
		else if(name[$2]==2)y[$2]++;
		else if(name[$2]==0)printf("this variable is not decleared before\n");
		else printf("this variable is not conpitable with operation\n");}

    | '-'ID'-' {if(name[$2]==1)x[$2]--;
		else if(name[$2]==2)y[$2]--;
		else if(name[$2]==0)printf("this variable is not decleared before\n");
		else printf("this variable is not conpitable with operation\n");}
    ;


		
ass: ID '=' stat {if(name[$1]==1)x[$1]=$3;
		  else if(name[$1]==2)y[$1]=$3;
		  else printf("not int or float\n");}

   | ID '=' CH {if(name[$1]==0)printf("the variabel not decleard\n");
		  else if(name[$1]==3)z[$1]=$3;
		  else printf("decleard in diff type\n");}

   | ID '=' CHH {if(name[$1]==0)printf("the variabel not decleard\n");
		  else if(name[$1]==4){int i; for(i=0;i<$3[0];i++) w[$1][i]=$3[i];}
		  else printf("not int or float\n");}

   | ID '=''+' stat {if(name[$1]==1)x[$1]+=$4;
		     else if(name[$1]==2)y[$1]+=$4;
		     else printf("not int or float\n");}

   | ID '=''-' stat {if(name[$1]==1)x[$1]-=$4;
		     else if(name[$1]==2)y[$1]-=$4;
		     else printf("not int or float\n");}

   | ID '=''*' stat {if(name[$1]==1)x[$1]*=$4;
		     else if(name[$1]==2)y[$1]*=$4;
		     else printf("not int or float\n");}

   | ID '=''/' stat {if(name[$1]==1)
			if($4==0)printf("div by zero\n");
			else x[$1]/=$4;
		     else if(name[$1]==2)
			if($4==0)printf("div by zero\n"); 
			else y[$1]/=$4;
		     else printf("not int or float\n");}
   ;



stat: stat '+' term {$$=$1+$3;}
    | stat '-' term {$$=$1-$3;}
    | term {$$=$1;}
    ;

term: term '*' fact {$$=$1*$3;}
    | term '/' fact {if($3==0)printf("divid by zero\n");else $$=$1/$3;}
    | fact {$$=$1;}
    ;

fact: ID          {if(name[$1]==0)printf("not decleard\n");
			else if(name[$1]==1)$$=x[$1];
			else $$=y[$1];}

    | '('stat')'  {$$=$2;}
    | NUM         {$$=$1;}
    | FLO         {$$=$1;}
    ;

%%

int yyerror(char* s)
{
   printf("error in %s \n",s);
   return 0;
}

int main()
{
   yyparse();
}