â
X/Users/samboers/development/order_management_system/OrderMicroservice/WeatherForecast.cs
	namespace 	
OrderMircroservice
 
; 
public 
class 
WeatherForecast 
{ 
public 

DateOnly 
Date 
{ 
get 
; 
set  #
;# $
}% &
public 

int 
TemperatureC 
{ 
get !
;! "
set# &
;& '
}( )
public		 

int		 
TemperatureF		 
=>		 
$num		 !
+		" #
(		$ %
int		% (
)		( )
(		) *
TemperatureC		* 6
/		7 8
$num		9 ?
)		? @
;		@ A
public 

string 
? 
Summary 
{ 
get  
;  !
set" %
;% &
}' (
} Ç!
P/Users/samboers/development/order_management_system/OrderMicroservice/Program.cs
var		 
builder		 
=		 
WebApplication		 
.		 
CreateBuilder		 *
(		* +
args		+ /
)		/ 0
;		0 1
ConfigurationManager

 
configuration

 "
=

# $
builder

% ,
.

, -
Configuration

- :
;

: ;
Console 
. 
	WriteLine 
( 
$str !
)! "
;" #
builder 
. 
Services 
. 
AddDbContext 
< 
AppDbContext *
>* +
(+ ,
options, 3
=>4 6
options 
. 
UseMySql 
( 
configuration "
." #
GetConnectionString# 6
(6 7
$str7 B
)B C
,C D
newE H
MySqlServerVersionI [
([ \
new\ _
Version` g
(g h
$numh j
,j k
$numl m
,m n
$numo p
)p q
)q r
)r s
)s t
;t u
builder 
. 
Services 
. 
AddControllers 
(  
)  !
;! "
builder 
. 
Services 
. #
AddEndpointsApiExplorer (
(( )
)) *
;* +
builder 
. 
Services 
. 
AddSwaggerGen 
( 
)  
;  !
builder 
. 
Services 
. 
	AddScoped 
< 
IMessageBusClient ,
,, -
MessageBusClient. >
>> ?
(? @
)@ A
;A B
builder 
. 
Services 
. 
	AddScoped 
< 

IOrderRepo %
,% &
	OrderRepo' 0
>0 1
(1 2
)2 3
;3 4
builder 
. 
Services 
. 
	AddScoped 
< 
IProductRepo '
,' (
ProductRepo) 4
>4 5
(5 6
)6 7
;7 8
builder 
. 
Services 
. 
AddHostedService !
<! " 
MessageBusSubscriber" 6
>6 7
(7 8
)8 9
;9 :
var 
app 
= 	
builder
 
. 
Build 
( 
) 
; 
using 
( 
var 

scope 
= 
app 
. 
Services 
.  
CreateScope  +
(+ ,
), -
)- .
{ 
var   
services   
=   
scope   
.   
ServiceProvider   (
;  ( )
var!! 
	dbContext!! 
=!! 
services!! 
.!! 
GetRequiredService!! /
<!!/ 0
AppDbContext!!0 <
>!!< =
(!!= >
)!!> ?
;!!? @
	dbContext"" 
."" 
Database"" 
."" 
Migrate"" 
("" 
)""  
;""  !
}## 
if&& 
(&& 
app&& 
.&& 
Environment&& 
.&& 
IsDevelopment&& !
(&&! "
)&&" #
)&&# $
{'' 
app(( 
.(( 

UseSwagger(( 
((( 
)(( 
;(( 
app)) 
.)) 
UseSwaggerUI)) 
()) 
))) 
;)) 
}** 
app,, 
.,, 
UseHttpsRedirection,, 
(,, 
),, 
;,, 
app.. 
... 
UseAuthorization.. 
(.. 
).. 
;.. 
app00 
.00 
MapControllers00 
(00 
)00 
;00 
app22 
.22 
Run22 
(22 
)22 	
;22	 
’
W/Users/samboers/development/order_management_system/OrderMicroservice/Models/Product.cs
	namespace 	
OrderMicroservice
 
. 
Models "
{ 
public 

class 
Product 
{ 
[ 	
Key	 
] 
public 
int 
ExternalProductId $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public		 
DateTime		 
Created		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
}

 
} ¤
X/Users/samboers/development/order_management_system/OrderMicroservice/Models/OrderRow.cs
	namespace 	
OrderMicroservice
 
. 
Models "
{ 
public 

class 
OrderRow 
{ 
[ 	
Key	 
] 
public		 
int		 

OrderRowId		 
{		 
get		  #
;		# $
set		% (
;		( )
}		* +
[ 	
Required	 
] 
public 
DateTime 
Created 
{  !
get" %
;% &
set' *
;* +
}, -
public 
int 
OrderId 
{ 
get  
;  !
set" %
;% &
}' (
public 
int 
	ProductId 
{ 
get "
;" #
set$ '
;' (
}) *
public 
int 
Quantity 
{ 
get !
;! "
set# &
;& '
}( )
public 
decimal 
Price 
{ 
get "
;" #
set$ '
;' (
}) *
[ 	

ForeignKey	 
( 
$str 
) 
] 
public 
Order 
Order 
{ 
get  
;  !
set" %
;% &
}' (
} 
} »
U/Users/samboers/development/order_management_system/OrderMicroservice/Models/Order.cs
	namespace 	
OrderMicroservice
 
. 
Models "
{ 
public 

class 
Order 
{ 
[ 	
Key	 
] 
public 
int 
OrderId 
{ 
get  
;  !
set" %
;% &
}' (
public

 
string

 

CustomerId

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
[ 	
Required	 
] 
public 
DateTime 
Created 
{  !
get" %
;% &
set' *
;* +
}, -
public 
ICollection 
< 
OrderRow #
># $
?$ %
	OrderRows& /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
} 
} ¦
z/Users/samboers/development/order_management_system/OrderMicroservice/Migrations/20231127092227_make_orderRows_nullable.cs
	namespace 	
OrderMicroservice
 
. 

Migrations &
{ 
public 

partial 
class #
make_orderRows_nullable 0
:1 2
	Migration3 <
{		 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
} 	
} 
} ð
ƒ/Users/samboers/development/order_management_system/OrderMicroservice/Migrations/20231127091023_changed_customerId_int_to_string.cs
	namespace 	
OrderMicroservice
 
. 

Migrations &
{ 
public 

partial 
class ,
 changed_customerId_int_to_string 9
:: ;
	Migration< E
{		 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
AlterColumn (
<( )
string) /
>/ 0
(0 1
name 
: 
$str "
," #
table 
: 
$str 
,  
type 
: 
$str  
,  !
nullable 
: 
false 
,  

oldClrType 
: 
typeof "
(" #
int# &
)& '
,' (
oldType 
: 
$str 
) 
. 

Annotation 
( 
$str +
,+ ,
$str- 6
)6 7
;7 8
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 
AlterColumn (
<( )
int) ,
>, -
(- .
name 
: 
$str "
," #
table 
: 
$str 
,  
type 
: 
$str 
, 
nullable 
: 
false 
,  

oldClrType 
: 
typeof "
(" #
string# )
)) *
,* +
oldType   
:   
$str   #
)  # $
.!! 
OldAnnotation!! 
(!! 
$str!! .
,!!. /
$str!!0 9
)!!9 :
;!!: ;
}"" 	
}## 
}$$ êB
p/Users/samboers/development/order_management_system/OrderMicroservice/Migrations/20231122102603_InitialCreate.cs
	namespace 	
OrderMicroservice
 
. 

Migrations &
{ 
public

 

partial

 
class

 
InitialCreate

 &
:

' (
	Migration

) 2
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
AlterDatabase *
(* +
)+ ,
. 

Annotation 
( 
$str +
,+ ,
$str- 6
)6 7
;7 8
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str 
, 
columns 
: 
table 
=> !
new" %
{ 
OrderId 
= 
table #
.# $
Column$ *
<* +
int+ .
>. /
(/ 0
type0 4
:4 5
$str6 ;
,; <
nullable= E
:E F
falseG L
)L M
. 

Annotation #
(# $
$str$ C
,C D(
MySqlValueGenerationStrategyE a
.a b
IdentityColumnb p
)p q
,q r

CustomerId 
=  
table! &
.& '
Column' -
<- .
int. 1
>1 2
(2 3
type3 7
:7 8
$str9 >
,> ?
nullable@ H
:H I
falseJ O
)O P
,P Q
Created 
= 
table #
.# $
Column$ *
<* +
DateTime+ 3
>3 4
(4 5
type5 9
:9 :
$str; H
,H I
nullableJ R
:R S
falseT Y
)Y Z
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 0
,0 1
x2 3
=>4 6
x7 8
.8 9
OrderId9 @
)@ A
;A B
} 
) 
. 

Annotation 
( 
$str +
,+ ,
$str- 6
)6 7
;7 8
migrationBuilder!! 
.!! 
CreateTable!! (
(!!( )
name"" 
:"" 
$str""  
,""  !
columns## 
:## 
table## 
=>## !
new##" %
{$$ 
ExternalProductId%% %
=%%& '
table%%( -
.%%- .
Column%%. 4
<%%4 5
int%%5 8
>%%8 9
(%%9 :
type%%: >
:%%> ?
$str%%@ E
,%%E F
nullable%%G O
:%%O P
false%%Q V
)%%V W
.&& 

Annotation&& #
(&&# $
$str&&$ C
,&&C D(
MySqlValueGenerationStrategy&&E a
.&&a b
IdentityColumn&&b p
)&&p q
,&&q r
Created'' 
='' 
table'' #
.''# $
Column''$ *
<''* +
DateTime''+ 3
>''3 4
(''4 5
type''5 9
:''9 :
$str''; H
,''H I
nullable''J R
:''R S
false''T Y
)''Y Z
}(( 
,(( 
constraints)) 
:)) 
table)) "
=>))# %
{** 
table++ 
.++ 

PrimaryKey++ $
(++$ %
$str++% 2
,++2 3
x++4 5
=>++6 8
x++9 :
.++: ;
ExternalProductId++; L
)++L M
;++M N
},, 
),, 
.-- 

Annotation-- 
(-- 
$str-- +
,--+ ,
$str--- 6
)--6 7
;--7 8
migrationBuilder// 
.// 
CreateTable// (
(//( )
name00 
:00 
$str00 !
,00! "
columns11 
:11 
table11 
=>11 !
new11" %
{22 

OrderRowId33 
=33  
table33! &
.33& '
Column33' -
<33- .
int33. 1
>331 2
(332 3
type333 7
:337 8
$str339 >
,33> ?
nullable33@ H
:33H I
false33J O
)33O P
.44 

Annotation44 #
(44# $
$str44$ C
,44C D(
MySqlValueGenerationStrategy44E a
.44a b
IdentityColumn44b p
)44p q
,44q r
Created55 
=55 
table55 #
.55# $
Column55$ *
<55* +
DateTime55+ 3
>553 4
(554 5
type555 9
:559 :
$str55; H
,55H I
nullable55J R
:55R S
false55T Y
)55Y Z
,55Z [
OrderId66 
=66 
table66 #
.66# $
Column66$ *
<66* +
int66+ .
>66. /
(66/ 0
type660 4
:664 5
$str666 ;
,66; <
nullable66= E
:66E F
false66G L
)66L M
,66M N
	ProductId77 
=77 
table77  %
.77% &
Column77& ,
<77, -
int77- 0
>770 1
(771 2
type772 6
:776 7
$str778 =
,77= >
nullable77? G
:77G H
false77I N
)77N O
,77O P
Quantity88 
=88 
table88 $
.88$ %
Column88% +
<88+ ,
int88, /
>88/ 0
(880 1
type881 5
:885 6
$str887 <
,88< =
nullable88> F
:88F G
false88H M
)88M N
,88N O
Price99 
=99 
table99 !
.99! "
Column99" (
<99( )
decimal99) 0
>990 1
(991 2
type992 6
:996 7
$str998 H
,99H I
nullable99J R
:99R S
false99T Y
)99Y Z
}:: 
,:: 
constraints;; 
:;; 
table;; "
=>;;# %
{<< 
table== 
.== 

PrimaryKey== $
(==$ %
$str==% 3
,==3 4
x==5 6
=>==7 9
x==: ;
.==; <

OrderRowId==< F
)==F G
;==G H
table>> 
.>> 

ForeignKey>> $
(>>$ %
name?? 
:?? 
$str?? ;
,??; <
column@@ 
:@@ 
x@@  !
=>@@" $
x@@% &
.@@& '
OrderId@@' .
,@@. /
principalTableAA &
:AA& '
$strAA( 0
,AA0 1
principalColumnBB '
:BB' (
$strBB) 2
,BB2 3
onDeleteCC  
:CC  !
ReferentialActionCC" 3
.CC3 4
CascadeCC4 ;
)CC; <
;CC< =
}DD 
)DD 
.EE 

AnnotationEE 
(EE 
$strEE +
,EE+ ,
$strEE- 6
)EE6 7
;EE7 8
migrationBuilderGG 
.GG 
CreateIndexGG (
(GG( )
nameHH 
:HH 
$strHH ,
,HH, -
tableII 
:II 
$strII "
,II" #
columnJJ 
:JJ 
$strJJ !
)JJ! "
;JJ" #
}KK 	
	protectedNN 
overrideNN 
voidNN 
DownNN  $
(NN$ %
MigrationBuilderNN% 5
migrationBuilderNN6 F
)NNF G
{OO 	
migrationBuilderPP 
.PP 
	DropTablePP &
(PP& '
nameQQ 
:QQ 
$strQQ !
)QQ! "
;QQ" #
migrationBuilderSS 
.SS 
	DropTableSS &
(SS& '
nameTT 
:TT 
$strTT  
)TT  !
;TT! "
migrationBuilderVV 
.VV 
	DropTableVV &
(VV& '
nameWW 
:WW 
$strWW 
)WW 
;WW  
}XX 	
}YY 
}ZZ ê
m/Users/samboers/development/order_management_system/OrderMicroservice/MessageBusEvents/UserRegisteredEvent.cs
	namespace 	
OrderMicroservice
 
. 
MessageBusEvents ,
{ 
public 

class 
UserRegisteredEvent $
{ 
public 
string 
UserId 
{ 
get "
;" #
set$ '
;' (
}) *
} 
} ò
m/Users/samboers/development/order_management_system/OrderMicroservice/MessageBusEvents/ProductCreatedEvent.cs
	namespace 	
OrderMicroservice
 
. 
MessageBusEvents ,
{ 
public 

class 
ProductCreatedEvent $
{ 
public 
int 
ExternalProductId $
{% &
get' *
;* +
set, /
;/ 0
}1 2
} 
} Ó
a/Users/samboers/development/order_management_system/OrderMicroservice/Dtos/MessagePublishedDto.cs
	namespace 	
OrderMicroservice
 
. 
Dtos  
{ 
public 

class 
MessagePublishedDto $
{ 
public 
string 
Message 
{ 
get  #
;# $
set% (
;( )
}* +
} 
} Ž
f/Users/samboers/development/order_management_system/OrderMicroservice/Data/Repositories/ProductRepo.cs
	namespace 	
OrderMicroservice
 
. 
Data  
.  !
Repositories! -
{ 
public 

class 
ProductRepo 
: 
IProductRepo +
{ 
private		 
readonly		 
AppDbContext		 %
_context		& .
;		. /
public 
ProductRepo 
( 
AppDbContext '
context( /
)/ 0
{ 	
_context 
= 
context 
; 
} 	
public 
void 
CreateProduct !
(! "
Product" )
product* 1
)1 2
{ 	
if 
( 
product 
== 
null 
)  
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
product7 >
)> ?
)? @
;@ A
} 
_context 
. 
Products 
. 
Add !
(! "
product" )
)) *
;* +
_context 
. 
SaveChanges  
(  !
)! "
;" #
} 	
public 
Product 
GetProductById %
(% &
int& )
	productId* 3
)3 4
{ 	
return 
_context 
. 
Products $
.$ %
FirstOrDefault% 3
(3 4
p4 5
=>6 8
p9 :
.: ;
ExternalProductId; L
==M O
	productIdP Y
)Y Z
;Z [
} 	
public   
async   
Task   
<   
bool   
>   
SaveChangesAsync    0
(  0 1
)  1 2
{!! 	
return"" 
await"" 
_context"" !
.""! "
SaveChangesAsync""" 2
(""2 3
)""3 4
>=""5 7
$num""8 9
;""9 :
}## 	
}$$ 
}%% Ñ
d/Users/samboers/development/order_management_system/OrderMicroservice/Data/Repositories/OrderRepo.cs
	namespace 	
OrderMicroservice
 
. 
Data  
.  !
Repositories! -
{ 
public 

class 
	OrderRepo 
: 

IOrderRepo '
{ 
private 
readonly 
AppDbContext %
_context& .
;. /
public

 
	OrderRepo

 
(

 
AppDbContext

 %
context

& -
)

- .
{ 	
_context 
= 
context 
; 
} 	
public 
void 
CreateOrder 
(  
Order  %
order& +
)+ ,
{ 	
_context 
. 
Orders 
. 
Add 
(  
order  %
)% &
;& '
_context 
. 
SaveChanges  
(  !
)! "
;" #
} 	
public 
IEnumerable 
< 
Order  
>  !
GetAllOrders" .
(. /
)/ 0
{ 	
return 
_context 
. 
Orders "
." #
ToList# )
() *
)* +
;+ ,
} 	
public 
Order  
GetOrderByCustomerId )
() *
string* 0
userId1 7
)7 8
{ 	
return 
_context 
. 
Orders "
." #
FirstOrDefault# 1
(1 2
o2 3
=>4 6
o7 8
.8 9

CustomerId9 C
==D F
userIdG M
)M N
;N O
} 	
public 
async 
Task 
< 
bool 
> 
SaveChangesAsync  0
(0 1
)1 2
{ 	
try   
{!! 
await"" 
_context"" 
."" 
SaveChangesAsync"" /
(""/ 0
)""0 1
;""1 2
return## 
true## 
;## 
}$$ 
catch%% 
(%% 
	Exception%% 
)%% 
{&& 
return(( 
false(( 
;(( 
})) 
}** 	
}++ 
},, ÷
e/Users/samboers/development/order_management_system/OrderMicroservice/Data/Interfaces/IProductRepo.cs
	namespace 	
OrderMicroservice
 
. 
Data  
.  !

Interfaces! +
{ 
public 

	interface 
IProductRepo !
{ 
void 
CreateProduct 
( 
Product "
product# *
)* +
;+ ,
Product		 
GetProductById		 
(		 
int		 "
	productId		# ,
)		, -
;		- .
Task

 
<

 
bool

 
>

 
SaveChangesAsync

 #
(

# $
)

$ %
;

% &
} 
} ‚
c/Users/samboers/development/order_management_system/OrderMicroservice/Data/Interfaces/IOrderRepo.cs
	namespace 	
OrderMicroservice
 
. 
Data  
.  !

Interfaces! +
{ 
public 

	interface 

IOrderRepo 
{ 
IEnumerable 
< 
Order 
> 
GetAllOrders '
(' (
)( )
;) *
void 
CreateOrder 
( 
Order 
order $
)$ %
;% &
Order		  
GetOrderByCustomerId		 "
(		" #
string		# )
userId		* 0
)		0 1
;		1 2
Task

 
<

 
bool

 
>

 
SaveChangesAsync

 #
(

# $
)

$ %
;

% &
} 
} º
Z/Users/samboers/development/order_management_system/OrderMicroservice/Data/AppDbContext.cs
	namespace 	
OrderMicroservice
 
. 
Data  
{ 
public 

class 
AppDbContext 
: 
	DbContext  )
{ 
public 
DbSet 
< 
Order 
> 
Orders "
{# $
get% (
;( )
set* -
;- .
}/ 0
public		 
DbSet		 
<		 
OrderRow		 
>		 
	OrderRows		 (
{		) *
get		+ .
;		. /
set		0 3
;		3 4
}		5 6
public

 
DbSet

 
<

 
Product

 
>

 
Products

 &
{

' (
get

) ,
;

, -
set

. 1
;

1 2
}

3 4
public 
AppDbContext 
( 
DbContextOptions ,
<, -
AppDbContext- 9
>9 :
options; B
)B C
:D E
baseF J
(J K
optionsK R
)R S
{ 	
} 	
	protected 
override 
void 
OnModelCreating  /
(/ 0
ModelBuilder0 <
modelBuilder= I
)I J
{ 	
modelBuilder 
. 
Entity 
<  
Order  %
>% &
(& '
)' (
. 
HasMany 
( 
o 
=> 
o 
.  
	OrderRows  )
)) *
. 
WithOne 
( 
or 
=> 
or !
.! "
Order" '
)' (
;( )
modelBuilder 
. 
Entity 
<  
OrderRow  (
>( )
() *
)* +
. 
HasOne 
( 
or 
=> 
or  
.  !
Order! &
)& '
. 
WithMany 
( 
o 
=> 
o  
.  !
	OrderRows! *
)* +
;+ ,
} 	
} 
} ð
n/Users/samboers/development/order_management_system/OrderMicroservice/Controllers/WeatherForecastController.cs
	namespace 	
OrderMircroservice
 
. 
Controllers (
;( )
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
public 
class %
WeatherForecastController &
:' (
ControllerBase) 7
{ 
private		 
static		 
readonly		 
string		 "
[		" #
]		# $
	Summaries		% .
=		/ 0
new		1 4
[		4 5
]		5 6
{

 
$str 
, 
$str 
, 
$str '
,' (
$str) /
,/ 0
$str1 7
,7 8
$str9 ?
,? @
$strA H
,H I
$strJ O
,O P
$strQ ]
,] ^
$str_ j
} 
; 
private 
readonly 
ILogger 
< %
WeatherForecastController 6
>6 7
_logger8 ?
;? @
public 
%
WeatherForecastController $
($ %
ILogger% ,
<, -%
WeatherForecastController- F
>F G
loggerH N
)N O
{ 
_logger 
= 
logger 
; 
} 
[ 
HttpGet 
( 
Name 
= 
$str (
)( )
]) *
public 

IEnumerable 
< 
WeatherForecast &
>& '
Get( +
(+ ,
), -
{ 
return 

Enumerable 
. 
Range 
(  
$num  !
,! "
$num# $
)$ %
.% &
Select& ,
(, -
index- 2
=>3 5
new6 9
WeatherForecast: I
{ 	
Date 
= 
DateOnly 
. 
FromDateTime (
(( )
DateTime) 1
.1 2
Now2 5
.5 6
AddDays6 =
(= >
index> C
)C D
)D E
,E F
TemperatureC 
= 
Random !
.! "
Shared" (
.( )
Next) -
(- .
-. /
$num/ 1
,1 2
$num3 5
)5 6
,6 7
Summary 
= 
	Summaries 
[  
Random  &
.& '
Shared' -
.- .
Next. 2
(2 3
	Summaries3 <
.< =
Length= C
)C D
]D E
} 	
)	 

. 	
ToArray	 
( 
) 
; 
} 
}   ‚
d/Users/samboers/development/order_management_system/OrderMicroservice/Controllers/OrderController.cs
	namespace 	
OrderMircroservice
 
. 
Controllers (
{ 
[ 
ApiController 
] 
[		 
Route		 

(		
 
$str		 
)		 
]		 
public

 

class

 
OrderController

  
:

! "
ControllerBase

# 1
{ 
private 
readonly 

IOrderRepo #
_repository$ /
;/ 0
public 
OrderController 
( 

IOrderRepo )

repository* 4
)4 5
{ 	
_repository 
= 

repository $
;$ %
} 	
[ 	
HttpGet	 
] 
public 
ActionResult 
< 
IEnumerable '
<' (
Order( -
>- .
>. /
GetAllOrders0 <
(< =
)= >
{ 	
var 
orders 
= 
_repository $
.$ %
GetAllOrders% 1
(1 2
)2 3
;3 4
return 
Ok 
( 
orders 
) 
; 
} 	
} 
} ¤
w/Users/samboers/development/order_management_system/OrderMicroservice/AsyncDataServices/Interfaces/IMessageBusClient.cs
	namespace 	
OrderMicroservice
 
. 
AsyncDataServices -
.- .

Interfaces. 8
{ 
public 

	interface 
IMessageBusClient &
{ 
void 
PublishNewMessage 
( 
MessagePublishedDto 2
messagePublishedDto3 F
)F G
;G H
} 
} Ó
f/Users/samboers/development/order_management_system/OrderMicroservice/Controllers/MessageController.cs
	namespace 	
OrderMicroservice
 
. 
Controllers '
{ 
[ 
Route 

(
 
$str 
) 
] 
[ 
ApiController 
] 
public 

class 
MessageController "
:# $
ControllerBase% 3
{		 
private

 
readonly

 
IMessageBusClient

 *
_messageBusClient

+ <
;

< =
public 
MessageController  
(  !
IMessageBusClient! 2
messageBusClient3 C
)C D
{ 	
_messageBusClient 
= 
messageBusClient  0
;0 1
} 	
[ 	
HttpPost	 
( 
$str 
) 
] 
public 
IActionResult 
PublishMessage +
(+ ,
[, -
FromBody- 5
]5 6
MessagePublishedDto7 J

messageDtoK U
)U V
{ 	
_messageBusClient 
. 
PublishNewMessage /
(/ 0

messageDto0 :
): ;
;; <
return 
Ok 
( 
$str 7
)7 8
;8 9
} 	
} 
} ‰¦
z/Users/samboers/development/order_management_system/OrderMicroservice/AsyncDataServices/Subscriber/MessageBusSubscriber.cs
	namespace 	
OrderMicroservice
 
. 
AsyncDataServices -
.- .

Subscriber. 8
{ 
public 

class  
MessageBusSubscriber %
:& '
BackgroundService( 9
{ 
private 
IConnection 
_connection '
;' (
private 
IModel 
_channel 
;  
private 
string 

_queueName !
;! "
private 
readonly  
IServiceScopeFactory -
_scopeFactory. ;
;; <
private 

IOrderRepo 
OrderRepository *
=>+ -
_scopeFactory. ;
.; <
CreateScope< G
(G H
)H I
.I J
ServiceProviderJ Y
.Y Z
GetRequiredServiceZ l
<l m

IOrderRepom w
>w x
(x y
)y z
;z {
private 
IProductRepo 
ProductRepository .
=>/ 1
_scopeFactory2 ?
.? @
CreateScope@ K
(K L
)L M
.M N
ServiceProviderN ]
.] ^
GetRequiredService^ p
<p q
IProductRepoq }
>} ~
(~ 
)	 €
;
€ 
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
public  
MessageBusSubscriber #
(# $
IConfiguration$ 2
configuration3 @
,@ A 
IServiceScopeFactoryB V
scopeFactoryW c
)c d
{ 	
try 
{ 
_configuration   
=    
configuration  ! .
;  . /
_scopeFactory!! 
=!! 
scopeFactory!!  ,
;!!, -
var"" !
redisConnectionString"" )
=""* +
$str"", O
;""O P
InitializeRabbitMQ## "
(##" #
)### $
;##$ %
}$$ 
catch%% 
(%% 
	Exception%% 
ex%% 
)%%  
{&& 
Console'' 
.'' 
	WriteLine'' !
(''! "
$"''" $
$str''$ ?
{''? @
ex''@ B
.''B C
Message''C J
}''J K
"''K L
)''L M
;''M N
}(( 
})) 	
private++ 
void++ 
InitializeRabbitMQ++ '
(++' (
)++( )
{,, 	
var-- 
factory-- 
=-- 
new-- 
ConnectionFactory-- /
(--/ 0
)--0 1
{.. 
HostName// 
=// 
_configuration// )
[//) *
$str//* 8
]//8 9
,//9 :
Port00 
=00 
int00 
.00 
Parse00  
(00  !
_configuration00! /
[00/ 0
$str000 >
]00> ?
)00? @
}11 
;11 
_connection33 
=33 
factory33 !
.33! "
CreateConnection33" 2
(332 3
)333 4
;334 5
_channel44 
=44 
_connection44 "
.44" #
CreateModel44# .
(44. /
)44/ 0
;440 1
_channel77 
.77 
ExchangeDeclare77 $
(77$ %
exchange77% -
:77- .
$str77/ ?
,77? @
type77A E
:77E F
ExchangeType77G S
.77S T
Topic77T Y
)77Y Z
;77Z [

_queueName:: 
=:: 
$str:: &
;::& '
_channel;; 
.;; 
QueueDeclare;; !
(;;! "
queue;;" '
:;;' (

_queueName;;) 3
,;;3 4
durable;;5 <
:;;< =
true;;> B
,;;B C
	exclusive;;D M
:;;M N
false;;O T
,;;T U

autoDelete;;V `
:;;` a
false;;b g
,;;g h
	arguments;;i r
:;;r s
null;;t x
);;x y
;;;y z
_channel>> 
.>> 
	QueueBind>> 
(>> 
queue>> $
:>>$ %

_queueName>>& 0
,>>0 1
exchange>>2 :
:>>: ;
$str>>< L
,>>L M

routingKey>>N X
:>>X Y
$str>>Z b
)>>b c
;>>c d
_channel?? 
.?? 
	QueueBind?? 
(?? 
queue?? $
:??$ %

_queueName??& 0
,??0 1
exchange??2 :
:??: ;
$str??< L
,??L M

routingKey??N X
:??X Y
$str??Z e
)??e f
;??f g
ConsoleAA 
.AA 
	WriteLineAA 
(AA 
$strAA C
)AAC D
;AAD E
_connectionCC 
.CC 
ConnectionShutdownCC *
+=CC+ -'
RabbitMQ_ConnectionShutdownCC. I
;CCI J
}DD 	
	protectedGG 
overrideGG 
TaskGG 
ExecuteAsyncGG  ,
(GG, -
CancellationTokenGG- >
stoppingTokenGG? L
)GGL M
{HH 	
stoppingTokenII 
.II (
ThrowIfCancellationRequestedII 6
(II6 7
)II7 8
;II8 9
varLL !
acknowledgmentHandlerLL %
=LL& '
newLL( +!
AcknowledgmentHandlerLL, A
(LLA B
_configurationLLB P
,LLP Q
_scopeFactoryLLR _
)LL_ `
;LL` a!
acknowledgmentHandlerMM !
.MM! "
StartMM" '
(MM' (
)MM( )
;MM) *
varOO 
consumerOO 
=OO 
newOO !
EventingBasicConsumerOO 4
(OO4 5
_channelOO5 =
)OO= >
;OO> ?
consumerQQ 
.QQ 
ReceivedQQ 
+=QQ  
asyncQQ! &
(QQ' (
ModuleHandleQQ( 4
,QQ4 5
eaQQ6 8
)QQ8 9
=>QQ: <
{RR 
trySS 
{TT 
byteUU 
[UU 
]UU 
bodyUU 
=UU  !
eaUU" $
.UU$ %
BodyUU% )
.UU) *
ToArrayUU* 1
(UU1 2
)UU2 3
;UU3 4
stringVV 
serializedMessageVV ,
=VV- .
EncodingVV/ 7
.VV7 8
UTF8VV8 <
.VV< =
	GetStringVV= F
(VVF G
bodyVVG K
)VVK L
;VVL M
ifXX 
(XX 
eaXX 
.XX 

RoutingKeyXX %
==XX& (
$strXX) :
)XX: ;
{YY 
varZZ 
userRegisteredEventZZ /
=ZZ0 1
JsonSerializerZZ2 @
.ZZ@ A
DeserializeZZA L
<ZZL M
UserRegisteredEventZZM `
>ZZ` a
(ZZa b
serializedMessageZZb s
)ZZs t
;ZZt u
await]] &
ProcessUserRegisteredEvent]] 8
(]]8 9
userRegisteredEvent]]9 L
,]]L M
OrderRepository]]N ]
)]]] ^
;]]^ _
SendAcknowledgment`` *
(``* +
userRegisteredEvent``+ >
.``> ?
UserId``? E
)``E F
;``F G
_channelcc  
.cc  !
BasicAckcc! )
(cc) *
eacc* ,
.cc, -
DeliveryTagcc- 8
,cc8 9
falsecc: ?
)cc? @
;cc@ A
}dd 
elseee 
ifee 
(ee 
eaee 
.ee  

RoutingKeyee  *
==ee+ -
$stree. ?
)ee? @
{ff 
vargg 
productCreatedEventgg /
=gg0 1
JsonSerializergg2 @
.gg@ A
DeserializeggA L
<ggL M
ProductCreatedEventggM `
>gg` a
(gga b
serializedMessageggb s
)ggs t
;ggt u
Consolehh 
.hh  
	WriteLinehh  )
(hh) *
productCreatedEventhh* =
)hh= >
;hh> ?
awaitkk !
ProcessProductCreatedkk 3
(kk3 4
productCreatedEventkk4 G
,kkG H
ProductRepositorykkI Z
)kkZ [
;kk[ \
SendAcknowledgmentnn *
(nn* +
productCreatedEventnn+ >
.nn> ?
ExternalProductIdnn? P
.nnP Q
ToStringnnQ Y
(nnY Z
)nnZ [
)nn[ \
;nn\ ]
_channelqq  
.qq  !
BasicAckqq! )
(qq) *
eaqq* ,
.qq, -
DeliveryTagqq- 8
,qq8 9
falseqq: ?
)qq? @
;qq@ A
}rr 
elserr 
{ss 
Consolett 
.tt  
	WriteLinett  )
(tt) *
$"tt* ,
$strtt, \
{tt\ ]
eatt] _
.tt_ `

RoutingKeytt` j
}ttj k
"ttk l
)ttl m
;ttm n
_channeluu  
.uu  !
	BasicNackuu! *
(uu* +
eauu+ -
.uu- .
DeliveryTaguu. 9
,uu9 :
falseuu; @
,uu@ A
falseuuB G
)uuG H
;uuH I
}vv 
}ww 
catchxx 
(xx 
	Exceptionxx  
exxx! #
)xx# $
{yy 
Consolezz 
.zz 
	WriteLinezz %
(zz% &
$"zz& (
$strzz( I
{zzI J
exzzJ L
.zzL M
MessagezzM T
}zzT U
"zzU V
)zzV W
;zzW X
}{{ 
}|| 
;|| 
_channel 
. 
BasicConsume !
(! "
queue" '
:' (

_queueName) 3
,3 4
autoAck5 <
:< =
false> C
,C D
consumerE M
:M N
consumerO W
)W X
;X Y
return
 
Task
 
.
 
CompletedTask
 %
;
% &
}
‚‚ 	
private
„„ 
async
„„ 
Task
„„ (
ProcessUserRegisteredEvent
„„ 5
(
„„5 6!
UserRegisteredEvent
„„6 I!
userRegisteredEvent
„„J ]
,
„„] ^

IOrderRepo
„„_ i
orderRepository
„„j y
)
„„y z
{
…… 	
Console
†† 
.
†† 
	WriteLine
†† 
(
†† 
$str
†† B
)
††B C
;
††C D
Console
‡‡ 
.
‡‡ 
	WriteLine
‡‡ 
(
‡‡ 
$"
‡‡  
$str
‡‡  ,
{
‡‡, -!
userRegisteredEvent
‡‡- @
.
‡‡@ A
UserId
‡‡A G
}
‡‡G H
"
‡‡H I
)
‡‡I J
;
‡‡J K
var
ŠŠ 
existingOrder
ŠŠ 
=
ŠŠ 
orderRepository
ŠŠ  /
.
ŠŠ/ 0"
GetOrderByCustomerId
ŠŠ0 D
(
ŠŠD E!
userRegisteredEvent
ŠŠE X
.
ŠŠX Y
UserId
ŠŠY _
)
ŠŠ_ `
;
ŠŠ` a
if
‹‹ 
(
‹‹ 
existingOrder
‹‹ 
!=
‹‹  
null
‹‹! %
)
‹‹% &
{
ŒŒ 
Console
 
.
 
	WriteLine
 !
(
! "
$"
" $
$str
$ I
{
I J!
userRegisteredEvent
J ]
.
] ^
UserId
^ d
}
d e
"
e f
)
f g
;
g h
return
ŽŽ 
;
ŽŽ 
}
 
var
‘‘ 
order
‘‘ 
=
‘‘ 
new
‘‘ 
Models
‘‘ "
.
‘‘" #
Order
‘‘# (
{
’’ 

CustomerId
““ 
=
““ !
userRegisteredEvent
““ 0
.
““0 1
UserId
““1 7
,
““7 8
Created
”” 
=
”” 
DateTime
”” "
.
””" #
UtcNow
””# )
}
•• 
;
•• 
orderRepository
—— 
.
—— 
CreateOrder
—— '
(
——' (
order
——( -
)
——- .
;
——. /
await
™™ 
orderRepository
™™ !
.
™™! "
SaveChangesAsync
™™" 2
(
™™2 3
)
™™3 4
;
™™4 5
Console
›› 
.
›› 
	WriteLine
›› 
(
›› 
$str
›› Z
)
››Z [
;
››[ \
}
œœ 	
private
žž 
async
žž 
Task
žž #
ProcessProductCreated
žž 0
(
žž0 1!
ProductCreatedEvent
žž1 D!
productCreatedEvent
žžE X
,
žžX Y
IProductRepo
žžZ f
productRepository
žžg x
)
žžx y
{
ŸŸ 	
Console
   
.
   
	WriteLine
   
(
   
$str
   B
)
  B C
;
  C D
Console
¡¡ 
.
¡¡ 
	WriteLine
¡¡ 
(
¡¡ 
$"
¡¡  
$str
¡¡  /
{
¡¡/ 0!
productCreatedEvent
¡¡0 C
.
¡¡C D
ExternalProductId
¡¡D U
}
¡¡U V
"
¡¡V W
)
¡¡W X
;
¡¡X Y
var
¤¤ 
existingOrder
¤¤ 
=
¤¤ 
productRepository
¤¤  1
.
¤¤1 2
GetProductById
¤¤2 @
(
¤¤@ A!
productCreatedEvent
¤¤A T
.
¤¤T U
ExternalProductId
¤¤U f
)
¤¤f g
;
¤¤g h
if
¥¥ 
(
¥¥ 
existingOrder
¥¥ 
!=
¥¥  
null
¥¥! %
)
¥¥% &
{
¦¦ 
Console
§§ 
.
§§ 
	WriteLine
§§ !
(
§§! "
$"
§§" $
$str
§§$ H
{
§§H I!
productCreatedEvent
§§I \
.
§§\ ]
ExternalProductId
§§] n
}
§§n o
"
§§o p
)
§§p q
;
§§q r
return
¨¨ 
;
¨¨ 
}
©© 
var
«« 
product
«« 
=
«« 
new
«« 
Product
«« %
{
¬¬ 
ExternalProductId
­­ !
=
­­" #!
productCreatedEvent
­­$ 7
.
­­7 8
ExternalProductId
­­8 I
,
­­I J
Created
®® 
=
®® 
DateTime
®® "
.
®®" #
UtcNow
®®# )
}
¯¯ 
;
¯¯ 
productRepository
±± 
.
±± 
CreateProduct
±± +
(
±±+ ,
product
±±, 3
)
±±3 4
;
±±4 5
await
³³ 
productRepository
³³ #
.
³³# $
SaveChangesAsync
³³$ 4
(
³³4 5
)
³³5 6
;
³³6 7
Console
µµ 
.
µµ 
	WriteLine
µµ 
(
µµ 
$"
µµ  
$str
µµ  >
{
µµ> ?!
productCreatedEvent
µµ? R
.
µµR S
ExternalProductId
µµS d
}
µµd e
"
µµe f
)
µµf g
;
µµg h
}
¶¶ 	
private
¹¹ 
void
¹¹  
SendAcknowledgment
¹¹ '
(
¹¹' (
string
¹¹( .
userId
¹¹/ 5
)
¹¹5 6
{
ºº 	
using
»» 
(
»» 
var
»» #
acknowledgmentChannel
»» ,
=
»»- .
_connection
»»/ :
.
»»: ;
CreateModel
»»; F
(
»»F G
)
»»G H
)
»»H I
{
¼¼ #
acknowledgmentChannel
½½ %
.
½½% &
ExchangeDeclare
½½& 5
(
½½5 6
exchange
½½6 >
:
½½> ?
$str
½½@ N
,
½½N O
type
½½P T
:
½½T U
ExchangeType
½½V b
.
½½b c
Fanout
½½c i
)
½½i j
;
½½j k
var
¿¿ #
acknowledgmentMessage
¿¿ )
=
¿¿* +
Encoding
¿¿, 4
.
¿¿4 5
UTF8
¿¿5 9
.
¿¿9 :
GetBytes
¿¿: B
(
¿¿B C
$"
¿¿C E
$str
¿¿E X
{
¿¿X Y
userId
¿¿Y _
}
¿¿_ `
"
¿¿` a
)
¿¿a b
;
¿¿b c#
acknowledgmentChannel
ÀÀ %
.
ÀÀ% &
BasicPublish
ÀÀ& 2
(
ÀÀ2 3
exchange
ÀÀ3 ;
:
ÀÀ; <
$str
ÀÀ= K
,
ÀÀK L

routingKey
ÀÀM W
:
ÀÀW X
$str
ÀÀY [
,
ÀÀ[ \
basicProperties
ÀÀ] l
:
ÀÀl m
null
ÀÀn r
,
ÀÀr s
body
ÀÀt x
:
ÀÀx y$
acknowledgmentMessageÀÀz 
)ÀÀ 
;ÀÀ ‘
}
ÁÁ 
}
ÂÂ 	
private
ÄÄ 
void
ÄÄ )
RabbitMQ_ConnectionShutdown
ÄÄ 0
(
ÄÄ0 1
object
ÄÄ1 7
sender
ÄÄ8 >
,
ÄÄ> ?
ShutdownEventArgs
ÄÄ@ Q
e
ÄÄR S
)
ÄÄS T
{
ÅÅ 	
Console
ÆÆ 
.
ÆÆ 
	WriteLine
ÆÆ 
(
ÆÆ 
$str
ÆÆ @
)
ÆÆ@ A
;
ÆÆA B
}
ÇÇ 	
}
ÈÈ 
public
ÊÊ 

class
ÊÊ #
AcknowledgmentHandler
ÊÊ &
{
ËË 
private
ÌÌ 
IConnection
ÌÌ 
_connection
ÌÌ '
;
ÌÌ' (
private
ÍÍ 
IModel
ÍÍ 
_channel
ÍÍ 
;
ÍÍ  
private
ÎÎ 
readonly
ÎÎ "
IServiceScopeFactory
ÎÎ -
_scopeFactory
ÎÎ. ;
;
ÎÎ; <
private
ÏÏ 
readonly
ÏÏ 
IConfiguration
ÏÏ '
_configuration
ÏÏ( 6
;
ÏÏ6 7
public
ÑÑ #
AcknowledgmentHandler
ÑÑ $
(
ÑÑ$ %
IConfiguration
ÑÑ% 3
configuration
ÑÑ4 A
,
ÑÑA B"
IServiceScopeFactory
ÑÑC W
scopeFactory
ÑÑX d
)
ÑÑd e
{
ÒÒ 	
_configuration
ÓÓ 
=
ÓÓ 
configuration
ÓÓ *
;
ÓÓ* +
_scopeFactory
ÔÔ 
=
ÔÔ 
scopeFactory
ÔÔ (
;
ÔÔ( )
}
ÕÕ 	
public
×× 
void
×× 
Start
×× 
(
×× 
)
×× 
{
ØØ 	
var
ÙÙ 
factory
ÙÙ 
=
ÙÙ 
new
ÙÙ 
ConnectionFactory
ÙÙ /
(
ÙÙ/ 0
)
ÙÙ0 1
{
ÚÚ 
HostName
ÛÛ 
=
ÛÛ 
_configuration
ÛÛ )
[
ÛÛ) *
$str
ÛÛ* 8
]
ÛÛ8 9
,
ÛÛ9 :
Port
ÜÜ 
=
ÜÜ 
int
ÜÜ 
.
ÜÜ 
Parse
ÜÜ  
(
ÜÜ  !
_configuration
ÜÜ! /
[
ÜÜ/ 0
$str
ÜÜ0 >
]
ÜÜ> ?
)
ÜÜ? @
}
ÝÝ 
;
ÝÝ 
_connection
ßß 
=
ßß 
factory
ßß !
.
ßß! "
CreateConnection
ßß" 2
(
ßß2 3
)
ßß3 4
;
ßß4 5
_channel
àà 
=
àà 
_connection
àà "
.
àà" #
CreateModel
àà# .
(
àà. /
)
àà/ 0
;
àà0 1
_channel
áá 
.
áá 
ExchangeDeclare
áá $
(
áá$ %
exchange
áá% -
:
áá- .
$str
áá/ =
,
áá= >
type
áá? C
:
ááC D
ExchangeType
ááE Q
.
ááQ R
Fanout
ááR X
)
ááX Y
;
ááY Z
var
ãã %
acknowledgmentQueueName
ãã '
=
ãã( )
_channel
ãã* 2
.
ãã2 3
QueueDeclare
ãã3 ?
(
ãã? @
)
ãã@ A
.
ããA B
	QueueName
ããB K
;
ããK L
_channel
ää 
.
ää 
	QueueBind
ää 
(
ää 
queue
ää $
:
ää$ %%
acknowledgmentQueueName
ää& =
,
ää= >
exchange
ää? G
:
ääG H
$str
ääI W
,
ääW X

routingKey
ääY c
:
ääc d
$str
ääe g
)
ääg h
;
ääh i
var
ææ 
consumer
ææ 
=
ææ 
new
ææ #
EventingBasicConsumer
ææ 4
(
ææ4 5
_channel
ææ5 =
)
ææ= >
;
ææ> ?
consumer
èè 
.
èè 
Received
èè 
+=
èè  
(
èè! "
ModuleHandle
èè" .
,
èè. /
ea
èè0 2
)
èè2 3
=>
èè4 6
{
éé 
Console
êê 
.
êê 
	WriteLine
êê !
(
êê! "
$"
êê" $
$str
êê$ =
{
êê= >
Encoding
êê> F
.
êêF G
UTF8
êêG K
.
êêK L
	GetString
êêL U
(
êêU V
ea
êêV X
.
êêX Y
Body
êêY ]
.
êê] ^
ToArray
êê^ e
(
êêe f
)
êêf g
)
êêg h
}
êêh i
"
êêi j
)
êêj k
;
êêk l
}
ëë 
;
ëë 
_channel
íí 
.
íí 
BasicConsume
íí !
(
íí! "
queue
íí" '
:
íí' (%
acknowledgmentQueueName
íí) @
,
íí@ A
autoAck
ííB I
:
ííI J
true
ííK O
,
ííO P
consumer
ííQ Y
:
ííY Z
consumer
íí[ c
)
ííc d
;
ííd e
}
îî 	
}
ïï 
}ðð À+
{/Users/samboers/development/order_management_system/OrderMicroservice/AsyncDataServices/Implementations/MessageBusClient.cs
	namespace 	
OrderMicroservice
 
. 
AsyncDataServices -
.- .
Implementations. =
{ 
public		 

class		 
MessageBusClient		 !
:		" #
IMessageBusClient		$ 5
{

 
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
private 
readonly 
IConnection $
_connection% 0
;0 1
private 
readonly 
IModel 
_channel  (
;( )
public 
MessageBusClient 
(  
IConfiguration  .
configuration/ <
)< =
{ 	
_configuration 
= 
configuration *
;* +
ConnectionFactory 
factory %
=& '
new( +
ConnectionFactory, =
(= >
)> ?
{ 
HostName 
= 
_configuration )
[) *
$str* 8
]8 9
,9 :
Port 
= 
int 
. 
Parse  
(  !
_configuration! /
[/ 0
$str0 >
]> ?
)? @
} 
; 
try 
{ 
_connection 
= 
factory %
.% &
CreateConnection& 6
(6 7
)7 8
;8 9
_channel 
= 
_connection &
.& '
CreateModel' 2
(2 3
)3 4
;4 5
_channel 
. 
ExchangeDeclare (
(( )
exchange) 1
:1 2
$str3 <
,< =
type> B
:B C
ExchangeTypeD P
.P Q
FanoutQ W
)W X
;X Y
_connection 
. 
ConnectionShutdown .
+=/ 1'
RabbitMQ_ConnectionShutdown2 M
;M N
Console!! 
.!! 
	WriteLine!! !
(!!! "
$str!!" @
)!!@ A
;!!A B
}"" 
catch## 
(## 
	Exception## 
ex## 
)## 
{$$ 
Console%% 
.%% 
	WriteLine%% !
(%%! "
$"%%" $
$str%%$ J
{%%J K
ex%%K M
.%%M N
Message%%N U
}%%U V
"%%V W
)%%W X
;%%X Y
}&& 
}'' 	
public(( 
void(( 
PublishNewMessage(( %
(((% &
MessagePublishedDto((& 9
messagePublishedDto((: M
)((M N
{)) 	
string** 
message** 
=** 
JsonSerializer** +
.**+ ,
	Serialize**, 5
(**5 6
messagePublishedDto**6 I
)**I J
;**J K
if,, 
(,, 
_connection,, 
.,, 
IsOpen,, !
),,! "
{-- 
Console.. 
... 
	WriteLine.. !
(..! "
$str.." T
)..T U
;..U V
SendMessage// 
(// 
message// #
)//# $
;//$ %
}00 
else11 
{22 
Console33 
.33 
	WriteLine33 !
(33! "
$str33" O
)33O P
;33P Q
}44 
}55 	
private77 
void77 
SendMessage77  
(77  !
string77! '
message77( /
)77/ 0
{88 	
var99 
body99 
=99 
Encoding99 
.99  
UTF899  $
.99$ %
GetBytes99% -
(99- .
message99. 5
)995 6
;996 7
_channel;; 
.;; 
BasicPublish;; !
(;;! "
exchange;;" *
:;;* +
$str;;, 5
,;;5 6

routingKey<<" ,
:<<, -
$str<<. 0
,<<0 1
basicProperties==" 1
:==1 2
null==3 7
,==7 8
body>>" &
:>>& '
body>>( ,
)>>, -
;>>- .
Console?? 
.?? 
	WriteLine?? 
(?? 
$"??  
$str??  1
{??1 2
message??2 9
}??9 :
"??: ;
)??; <
;??< =
}@@ 	
publicBB 
voidBB 
DisposeBB 
(BB 
)BB 
{CC 	
ConsoleDD 
.DD 
	WriteLineDD 
(DD 
$strDD 3
)DD3 4
;DD4 5
ifEE 
(EE 
_channelEE 
.EE 
IsOpenEE 
)EE 
{FF 
_channelGG 
.GG 
CloseGG 
(GG 
)GG  
;GG  !
_connectionHH 
.HH 
CloseHH !
(HH! "
)HH" #
;HH# $
}II 
}JJ 	
privateLL 
voidLL '
RabbitMQ_ConnectionShutdownLL 0
(LL0 1
objectLL1 7
senderLL8 >
,LL> ?
ShutdownEventArgsLL@ Q
eLLR S
)LLS T
{MM 	
ConsoleNN 
.NN 
	WriteLineNN 
(NN 
$strNN @
)NN@ A
;NNA B
}OO 	
}PP 
}QQ 