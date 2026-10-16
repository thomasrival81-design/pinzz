import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:video_player/video_player.dart';
import 'services/auth_api.dart';

const cyan = Color(0xFF00E5FF);
const bg = Color(0xFF05090D);
const storage = FlutterSecureStorage();

void main() => runApp(const PinzxApp());

class PinzxApp extends StatelessWidget {
  const PinzxApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'PINZX', debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: bg, colorScheme: ColorScheme.fromSeed(seedColor: cyan, brightness: Brightness.dark),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: const Color(0xFF0C151C),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF183541))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF183541))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: cyan))),
    ), home: const FingerprintPage());
}

class PinzxScaffold extends StatelessWidget {
  const PinzxScaffold({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Scaffold(body: Stack(children: [
    Positioned.fill(child: CustomPaint(painter: GridPainter())),
    SafeArea(child: child),
  ]));
}
class GridPainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size) {
    final p = Paint()..color = cyan.withOpacity(.055)..strokeWidth = .5;
    for (double x=0; x<size.width; x+=26) { canvas.drawLine(Offset(x,0), Offset(x,size.height),p); }
    for (double y=0; y<size.height; y+=26) { canvas.drawLine(Offset(0,y), Offset(size.width,y),p); }
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
}
Widget brand({double size=34}) => Image.asset('assets/images/pinzx_logo.png', width:size, height:size, errorBuilder: (_,__,___)=>const Icon(Icons.bolt,color:cyan));
Widget heading(String text, {double size=26}) => Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize:size,fontWeight:FontWeight.w900,letterSpacing:2,color:Colors.white));
Widget cyanButton(String text, VoidCallback? onTap) => SizedBox(width:double.infinity,height:52,child:ElevatedButton(
  style:ElevatedButton.styleFrom(backgroundColor:cyan,foregroundColor:bg,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))),
  onPressed:onTap, child:Text(text,style:const TextStyle(fontWeight:FontWeight.w900,letterSpacing:1.3))));

class FingerprintPage extends StatefulWidget { const FingerprintPage({super.key}); @override State<FingerprintPage> createState()=>_FingerprintPageState(); }
class _FingerprintPageState extends State<FingerprintPage> {
 double progress=0; bool running=false;
 void start(){ if(running)return; setState(()=>running=true); Future.doWhile(() async { await Future.delayed(const Duration(milliseconds:45)); if(!mounted)return false; setState(()=>progress=(progress+.012).clamp(0,1)); if(progress>=1){setState(()=>running=false); await Future.delayed(const Duration(milliseconds:250)); if(mounted)Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const LandingPage())); return false;} return running; }); }
 void reset(){if(!running)setState(()=>progress=0);}
 @override Widget build(BuildContext context)=>PinzxScaffold(child:Center(child:Padding(padding:const EdgeInsets.all(28),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[brand(size:80),const SizedBox(height:20),heading('PINZX',size:36),const SizedBox(height:8),const Text('SECURE ACCESS PROTOCOL',style:TextStyle(color:cyan,letterSpacing:3)),const SizedBox(height:42),GestureDetector(onLongPressStart:(_)=>start(),onLongPressEnd:(_)=>reset(),child:Container(width:150,height:150,decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:cyan.withOpacity(.55),width:2),boxShadow:[BoxShadow(color:cyan.withOpacity(.12),blurRadius:30)]),child:Stack(alignment:Alignment.center,children:[SizedBox(width:130,height:130,child:CircularProgressIndicator(value:progress,strokeWidth:4,color:cyan,backgroundColor:cyan.withOpacity(.12))),const Icon(Icons.fingerprint,size:76,color:cyan)]))),const SizedBox(height:24),Text('${(progress*100).round()}%',style:const TextStyle(color:cyan,fontSize:24,fontWeight:FontWeight.bold)),const SizedBox(height:10),const Text('TEKAN DAN TAHAN SENSOR UNTUK MEMULAI',textAlign:TextAlign.center,style:TextStyle(color:Colors.white70,fontSize:11,letterSpacing:1.2)),])))); }

class LandingPage extends StatelessWidget { const LandingPage({super.key}); @override Widget build(BuildContext context)=>PinzxScaffold(child:ListView(padding:const EdgeInsets.all(24),children:[const SizedBox(height:24),Center(child:brand(size:84)),const SizedBox(height:20),heading('PINZX',size:42),const SizedBox(height:10),const Text('NEXT-GEN DIGITAL TOOLKIT',textAlign:TextAlign.center,style:TextStyle(color:cyan,letterSpacing:3)),const SizedBox(height:30),Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(color:const Color(0xCC09131A),border:Border.all(color:cyan.withOpacity(.45)),borderRadius:BorderRadius.circular(18)),child:Column(children:[heading('BUILT FOR CONTROL',size:20),const SizedBox(height:12),const Text('A clean, futuristic workspace for your digital utilities.',textAlign:TextAlign.center,style:TextStyle(color:Colors.white70,height:1.6)),const SizedBox(height:24),cyanButton('GET STARTED NOW',()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const LoginPage())))])),const SizedBox(height:36),heading('OUR TEAM',size:20),const SizedBox(height:14),const TeamTile(name:'Valltyyy',handle:'@Valltyyy',role:'OWNER & DEVELOPER'),const SizedBox(height:24),const Center(child:Text('PINZX PROJECTS • 2026',style:TextStyle(color:Colors.white38,fontSize:10,letterSpacing:2)))])); }
class TeamTile extends StatelessWidget {const TeamTile({super.key,required this.name,required this.handle,required this.role});final String name,handle,role;@override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:const Color(0xCC09131A),borderRadius:BorderRadius.circular(14),border:Border.all(color:cyan.withOpacity(.25))),child:Row(children:[const CircleAvatar(backgroundColor:Color(0xFF12313A),child:Icon(Icons.person,color:cyan)),const SizedBox(width:14),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(name,style:const TextStyle(fontWeight:FontWeight.bold)),Text(handle,style:const TextStyle(color:cyan)),Text(role,style:const TextStyle(color:Colors.white54,fontSize:10))]))]));}

class LoginPage extends StatefulWidget {const LoginPage({super.key});@override State<LoginPage> createState()=>_LoginPageState();}
class _LoginPageState extends State<LoginPage>{final user=TextEditingController(),pass=TextEditingController();bool busy=false,hide=true;Future<void> submit()async{if(user.text.trim().isEmpty||pass.text.isEmpty){show('Isi username dan password.');return;}setState(()=>busy=true);final r=await AuthApi.login(user.text,pass.text);if(!mounted)return;setState(()=>busy=false);if(!r.ok){show(r.message=='API belum dikonfigurasi.'?r.message:'LOGIN GAGAL\n${r.message}');return;}if(r.token!=null)await storage.write(key:'pinzx_token',value:r.token);if(mounted)Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const IntroPage()));}void show(String s)=>showDialog(context:context,builder:(_)=>AlertDialog(backgroundColor:const Color(0xFF0B151B),title:Text(s.startsWith('LOGIN GAGAL')?'LOGIN GAGAL':'INFO',style:const TextStyle(color:cyan)),content:Text(s),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('OK'))]));@override void dispose(){user.dispose();pass.dispose();super.dispose();}
@override Widget build(BuildContext context)=>PinzxScaffold(child:Center(child:SingleChildScrollView(padding:const EdgeInsets.all(24),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[brand(size:72),const SizedBox(height:16),heading('LOGIN TO PINZX'),const SizedBox(height:8),const Text('AUTHENTICATED ACCESS ONLY',style:TextStyle(color:cyan,fontSize:10,letterSpacing:2)),const SizedBox(height:30),TextField(controller:user,autocorrect:false,decoration:const InputDecoration(labelText:'Username',prefixIcon:Icon(Icons.person_outline))),const SizedBox(height:14),TextField(controller:pass,obscureText:hide,decoration:InputDecoration(labelText:'Password',prefixIcon:const Icon(Icons.lock_outline),suffixIcon:IconButton(onPressed:()=>setState(()=>hide=!hide),icon:Icon(hide?Icons.visibility:Icons.visibility_off)))),const SizedBox(height:24),cyanButton(busy?'CONNECTING...':'LOGIN',busy?null:submit),const SizedBox(height:20),const Text('OWNER / DEVELOPER: Valltyyy • @Valltyyy',style:TextStyle(color:Colors.white38,fontSize:10))]))));}

class IntroPage extends StatefulWidget{const IntroPage({super.key});@override State<IntroPage> createState()=>_IntroPageState();}
class _IntroPageState extends State<IntroPage>{late VideoPlayerController controller;bool ready=false;@override void initState(){super.initState();controller=VideoPlayerController.asset('assets/videos/pinzx_intro.mp4')..initialize().then((_){if(!mounted)return;setState(()=>ready=true);controller.play();controller.addListener(check);});}void check(){if(controller.value.isInitialized&&controller.value.position>=controller.value.duration&&mounted)go();}void go(){controller.removeListener(check);Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const DashboardPage()));}@override void dispose(){controller.dispose();super.dispose();}@override Widget build(BuildContext context)=>PinzxScaffold(child:Center(child:Padding(padding:const EdgeInsets.all(18),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[heading('WELCOME TO PINZX'),const SizedBox(height:20),AspectRatio(aspectRatio:ready?controller.value.aspectRatio:16/9,child:ready?VideoPlayer(controller):const Center(child:CircularProgressIndicator(color:cyan))),const SizedBox(height:20),LinearProgressIndicator(value:ready&&controller.value.duration.inMilliseconds>0?controller.value.position.inMilliseconds/controller.value.duration.inMilliseconds:null,color:cyan,backgroundColor:cyan.withOpacity(.15)),const SizedBox(height:22),cyanButton('SKIP INTRO',go)]))));}

class DashboardPage extends StatelessWidget{const DashboardPage({super.key});static const items=[('UTILITY HUB','Tools and productivity utilities',Icons.grid_view),('ACCOUNT','Signed-in session settings',Icons.manage_accounts),('PROJECT INFO','PINZX • Valltyyy',Icons.info_outline),('SECURITY','Session and access status',Icons.shield_outlined)];@override Widget build(BuildContext context)=>PinzxScaffold(child:ListView(padding:const EdgeInsets.all(20),children:[Row(children:[brand(size:46),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[heading('PINZX',size:24),const Text('DASHBOARD / HOME',style:TextStyle(color:cyan,fontSize:10,letterSpacing:2))])),IconButton(onPressed:()async{await storage.delete(key:'pinzx_token');if(context.mounted)Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(_)=>const LandingPage()),(_)=>false);},icon:const Icon(Icons.logout,color:cyan))]),const SizedBox(height:22),Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(borderRadius:BorderRadius.circular(16),border:Border.all(color:cyan.withOpacity(.35)),color:const Color(0xCC09131A)),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('SYSTEM ONLINE',style:TextStyle(color:cyan,fontWeight:FontWeight.bold,letterSpacing:2)),SizedBox(height:8),Text('Welcome to your clean PINZX workspace.',style:TextStyle(color:Colors.white70))])),const SizedBox(height:20),GridView.builder(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),itemCount:items.length,gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,crossAxisSpacing:12,mainAxisSpacing:12,childAspectRatio:1.05),itemBuilder:(context,i){final a=items[i];return Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:const Color(0xCC09131A),borderRadius:BorderRadius.circular(14),border:Border.all(color:cyan.withOpacity(.24))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.center,children:[Icon(a.$3,color:cyan,size:30),const SizedBox(height:16),Text(a.$1,style:const TextStyle(fontWeight:FontWeight.w900,letterSpacing:1)),const SizedBox(height:6),Text(a.$2,style:const TextStyle(color:Colors.white54,fontSize:11)),const SizedBox(height:10),const Text('PREVIEW ONLY',style:TextStyle(color:cyan,fontSize:9,letterSpacing:1.5))]));}),const SizedBox(height:24),const Center(child:Text('OWNER & DEVELOPER: Valltyyy • @Valltyyy',style:TextStyle(color:Colors.white38,fontSize:10))) ]));}
