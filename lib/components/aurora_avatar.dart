import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:provider/provider.dart';
import 'package:aurora_assistant/services/voice_service.dart';

class AuroraAvatar extends StatefulWidget {
  final Function(String)? onVoiceCommand;
  
  const AuroraAvatar({
    super.key,
    this.onVoiceCommand,
  });

  @override
  State<AuroraAvatar> createState() => _AuroraAvatarState();
}

class _AuroraAvatarState extends State<AuroraAvatar> {
  late RiveAnimationController _controller;
  late RiveAnimationController _mouthController;
  bool _isSpeaking = false;
  String _responseText = 'Olá, Gabriel!';
  final List<String> _greetings = [
    'Olá, Gabriel! Como posso ajudar?',
    'Bom te ver, Gabriel! Pronto para ser produtivo?',
    'Saudações, Gabriel! O que vamos fazer hoje?'
  ];

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('idle');
    _mouthController = SimpleAnimation('mouth_default');
    _playGreeting();
    _initVoiceService();
  }

  void _initVoiceService() {
    final voiceService = Provider.of<VoiceService>(context, listen: false);
    voiceService.initialize();
  }

  void _playGreeting() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _controller = SimpleAnimation('greeting');
      _responseText = _greetings[DateTime.now().millisecond % _greetings.length];
    });
    
    final voiceService = Provider.of<VoiceService>(context, listen: false);
    await voiceService.speak(_responseText);
    
    setState(() {
      _controller = SimpleAnimation('idle');
    });
  }

  Future<void> _processVoiceCommand(String command) async {
    final voiceService = Provider.of<VoiceService>(context, listen: false);
    setState(() {
      _isSpeaking = true;
      _controller = SimpleAnimation('listening');
      _mouthController = SimpleAnimation('mouth_speaking');
    });

    // Process command
    String response;
    if (command.toLowerCase().contains('tarefa')) {
      response = 'Abrindo gerenciador de tarefas...';
      widget.onVoiceCommand?.call('tasks');
    } else if (command.toLowerCase().contains('calendário')) {
      response = 'Abrindo calendário...';
      widget.onVoiceCommand?.call('calendar');
    } else if (command.toLowerCase().contains('ajuda')) {
      response = 'Posso ajudar com tarefas, calendário, lembretes e mais. O que precisa?';
    } else {
      response = 'Desculpe, não entendi. Pode repetir?';
    }

    setState(() {
      _responseText = response;
    });

    await voiceService.speak(response);
    
    setState(() {
      _isSpeaking = false;
      _controller = SimpleAnimation('idle');
      _mouthController = SimpleAnimation('mouth_default');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: RiveAnimation.asset(
            'assets/animations/aurora.riv',
            controllers: [_controller, _mouthController],
          ),
        ),
        Text(
          _responseText,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Consumer<VoiceService>(
          builder: (context, voiceService, _) {
            return IconButton(
              icon: Icon(
                voiceService.isListening ? Icons.mic_off : Icons.mic,
                size: 32,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () async {
                if (voiceService.isListening) {
                  await voiceService.stopListening();
                } else {
                  await voiceService.startListening(_processVoiceCommand);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
