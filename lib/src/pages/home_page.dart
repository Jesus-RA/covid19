import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Opción seleccionada del BottomNavigator
  int _selectedIndex = 0;
  // Opciones del BottomNavigator
  List<Widget> _opciones = [];
  // Colores
  final _primary = Color(0xFF00E5FF);
  // final _primary = Color(0xFFB7EEEB);
  final _secondary = Color(0xFFFF80AB);
  final _bg = Color(0xFFBCFEDA);
  final _alert = Color(0xFFFF0000);

  // Video
  VideoPlayerController _controller;
  VideoPlayerController _controllerSD;
  VideoPlayerController _controllerCovid;
  bool _isPlaying = false;
  bool _isPlayingSD = false;
  bool _isPlayingCovid = false;


  @override
  void initState(){
    super.initState();
    // _controller = VideoPlayerController.network('https://www.youtube.com/watch?v=rF0I7-gmCSk')
    _controllerSD = VideoPlayerController.asset('assets/Susana_Distancia.mp4')
    ..addListener(() {
      final bool isPlaying = _controllerSD.value.isPlaying;
      if(isPlaying != _isPlayingSD){
        setState(() {
          _isPlayingSD = isPlaying;
          _controllerSD.setLooping(true);
        });
      }
    })
    ..initialize().then((_){
      setState(() {
        
      });
    });

    _controller = VideoPlayerController.asset('assets/historia.mp4')
    ..addListener(() {
      final bool isPlaying = _controller.value.isPlaying;
      if(isPlaying != _isPlaying){
        setState(() {
          _isPlaying = isPlaying;
          _controller.setLooping(true);
        });
      }
    })
    ..initialize().then((_){
      // Init first frame
      setState(() {
        
      });
    });

    _controllerCovid = VideoPlayerController.asset('assets/covid.mp4')
    ..addListener(() {
      final bool isPlaying = _controllerCovid.value.isPlaying;
      if(isPlaying != _isPlayingCovid){
        setState(() {
          _isPlayingCovid = isPlaying;
          _controllerCovid.setLooping(true);
        });
      }
    })
    ..initialize().then((_){
      // Init first frame
      setState(() {
        
      });
    });
  }
  // Video

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    _opciones = _crearOpciones();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Goodboy Covid-19',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: _primary,
      // ),
      body: _opciones.elementAt(_selectedIndex),
      backgroundColor: _bg,
      bottomNavigationBar: _crearBottom(),

    );
  }

  Widget _parrafo(String titulo, String parrafo){
    
    final _styleTitulo = TextStyle(fontSize: 20.0, color: _secondary, fontFamily: "FredokaOne-Regular", fontWeight: FontWeight.normal);
    final _styleParrafo = TextStyle(fontSize: 15.0, color: Colors.black, fontFamily: "FredokaOne-Regular", fontWeight: FontWeight.normal);

    return Container(//Contenedor en el que agregamos margen para centrar el texto.
      child: Center(//Centramos el contenido
            child: Column(//Lo metemos en una columna para poder controlar el titulo y el parrafo

              children: <Widget>[
                Text(//Titulo
                  titulo,
                  style: _styleTitulo,            
                ),
                Text(//Parrafo
                  parrafo,
                  style: _styleParrafo,
                  textAlign: TextAlign.center,
                ),

              ],
            ),

          ),
      margin: EdgeInsets.only(right:40.0, left: 30.0)
    );
  }

  Widget _reproductor(VideoPlayerController v, String titulo){
    return Column(
      children: <Widget>[
        SizedBox(height: 30.0,),
        Divider(height: 80.0,),
        Center(
          child: Text(
            titulo,
            style: TextStyle(fontSize: 30.0, color: _secondary, fontFamily: "FredokaOne-Regular", fontWeight: FontWeight.normal),
          ),
        ),
        SizedBox(height: 30.0,),
        v.value.initialized?AspectRatio(
          aspectRatio: v.value.aspectRatio,
          child: VideoPlayer(v),

        ):Container(),
        SizedBox(height:40.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,            
          children: <Widget>[
            FloatingActionButton(
              onPressed: v.value.isPlaying?v.pause:v.play,
              child: Icon(v.value.isPlaying?Icons.pause:Icons.play_arrow),
              backgroundColor: _secondary,
          
            ),
            SizedBox(width: 10.0,)
          ],
        ),        
      ],
    );
  }

  BottomNavigationBar _crearBottom(){
    return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report),
            title: Text('Covid-19'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            title: Text('Cuidados'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.developer_mode),
            title: Text('Desarrollador'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _bg,
        backgroundColor: _secondary,
        onTap: _onItemTapped,
    );
  }

  Widget _crearCard(){
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0,),
            Text(
              'Tarjeta',
              style: TextStyle(fontSize: 20.0, color: _secondary, fontFamily: "FredokaOne-Regular", fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 5.0,),
            Text(
              'Descripción tarjeta',
              style: TextStyle(fontSize: 15.0, color: Colors.black, fontFamily: "FredokaOne-Regular", fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 15.0,),
          ],
        ),
      ),
      shadowColor: _primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0)
      ),
      // color: Color.fromRGBO(135, 195, 209, 0.4),
      elevation: 0,
    );
  }

  List<Widget> _crearOpciones(){
    return [
      ListView(//Covid-19        
        children: <Widget>[
          SizedBox(height: 40.0,),
          Image.asset(
            'assets/covid.png',
              height: 350.0,
          ),
          _reproductor(_controllerCovid, 'Conóceme'),
          _reproductor(_controller, 'Una pequeña historia'),
          _reproductor(_controllerSD, 'Susana Distancia'),          
          SizedBox(height: 40.0,),
        ],        
      ),

      ListView(//Cuidados
        children: <Widget>[
          FadeInImage(
            image: NetworkImage('https://coronavirus.gob.mx/wp-content/uploads/2020/04/Plaza-Sesamo-Virus-02.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fit: BoxFit.fill,
          ),
          FadeInImage(
            image: NetworkImage('https://coronavirus.gob.mx/wp-content/uploads/2020/04/Plaza-Sesamo-Virus-05.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fit: BoxFit.fill,
          ),
          FadeInImage(
            image: NetworkImage('https://coronavirus.gob.mx/wp-content/uploads/2020/04/Plaza-Sesamo-Virus-06.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fit: BoxFit.fill,
          ),
          FadeInImage(
            image: NetworkImage('https://coronavirus.gob.mx/wp-content/uploads/2020/04/Guias-Para-Cuidadores-Podemos-Ayudar.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fit: BoxFit.fill,
          ),
          SizedBox(height: 40.0,),
          _parrafo('Susana Distancia', 'Recuerda mantener tu distancia con las personas.'),
          SizedBox(height: 40.0,),
          FadeInImage(
            image: NetworkImage('https://cdn-3.expansion.mx/dims4/default/0ddd814/2147483647/strip/true/crop/947x386+0+0/resize/1800x734!/quality/90/?url=https%3A%2F%2Fcdn-3.expansion.mx%2F17%2Fc3%2F5838eada4a6da35c75395651a0de%2F2020-03-20-1.png'),
            placeholder: AssetImage('assets/jar-loading.gif'),
          ),
          SizedBox(height: 40.0,),
          _parrafo('Cuídate','Así nos ayudas a mantenerlo alejado de todos.'),
          SizedBox(height: 40.0,),
          FadeInImage(
            image: NetworkImage('https://media.gettyimages.com/vectors/coronavirus-mug-shotviral-flu-epidemiccovid19-pandemic-concept-vector-id1212062224?s=2048x2048'),
            placeholder: AssetImage('assets/jar-loading.gif'),
          ),
        ],
      ),

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        textDirection: TextDirection.rtl,
        children: <Widget>[
          _parrafo('Desarrollador', 'Nombre: Jesús Ramírez Alejandro\nMatrícula: 201508989'),
          SizedBox(height: 40.0,),
          _parrafo('Version', '1.0.0'),
        ],
      ),
    ];
  }
}