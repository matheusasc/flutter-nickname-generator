import 'dart:math';

void main() {
  
  String nomeEntrada = 'Matheus Assuncao';
  
  List<String> sugestoesNickname = gerarnick(nomeEntrada);

  print('Sugestões de nicknames:');
  sugestoesNickname.forEach((nickname) {
    print(nickname);
  });
}

 List<String> gerarnick(String name){
   
   final random = Random();
   
   List<String> sugestaoNickname = [];
   
   sugestaoNickname.add(name);
   
   List<String> partesNome = name.split(' ');
   if(partesNome.length > 1) {
     String misturaNome = partesNome.reversed.join(' ');
     sugestaoNickname.add(misturaNome);
   }
   
   if(name.length > 3) {
     String cutNome = name.substring(0, name.length -2);
     sugestaoNickname.add(cutNome);
   }
     
   for (int i = 0; i < 3; i++) {
     String randomSufixo = random.nextInt(1000).toString();
     sugestaoNickname.add('$name$randomSufixo');
   }
   
  return sugestaoNickname;  
 }