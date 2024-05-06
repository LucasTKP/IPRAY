<h1 align="center">IPRAY</h1>
<div>
Repositório de um projeto que desenvolvi durante o mês de março e abril de 2024.
O aplicativo consiste em um registrador de rezas, onde o usuário entra todo dia e registra se rezou ou não, com isso ele pode subir ou descer no ranking.
Eu mesmo tive a ideia deste aplicativo e desenvolvi o design, fluxos de telas, front-end, modelagem do banco de dados e back-end.
</div>  


#

<div align="left"> 
  <strong>📚 Telas do App:</strong>
</div>

<div align="left"> 
   <strong>01. SplashPage:</strong> Exibe uma animação e verifica se o usuário está logado.
</div>

<div align="left"> 
   <strong>02. SignIn:</strong> Possibilita o usuário de entrar com o Google.
</div>

<div align="left"> 
   <strong>03. SignUp:</strong> Faz o cadastro das informações do usuário (nome, idade, estado e cidade).
</div>

<div align="left"> 
   <strong>04. Home:</strong> Exibe as informações das rezas do usuário e possibilita ele cadastrar novas rezas.
</div>

<div align="left"> 
   <strong>05. Ranking:</strong> Exibe o ranking de usuários que estão com mais rezas e os usuários que estão com mais dias seguidos rezando.
</div>

<br/>
    
<div align="left">  
  <strong> 💼 Tecnologias utilizadas: </strong>
</div>

<table align="center">
 <tr>
  <td>Flutter: 3.19.6</td>  
  <td>Flutter_svg: 2.0.10+1</td>
  <td>Firebase_auth: 4.19.1</td>
  <td>Google_sign_in: 6.2.1</td>
  <td>Table_calendar: 3.1.1</td>
  <td>Supabase: 2.5.0</td>
  <td>Flutter_dotenv: 5.1.0</td>
  <td>Mocktail: 1.0.3</td>
  <td>Firebase_messaging: 14.9.1</td>
  <td>Flutter_local_notifications: 17.1.0</td>
 </tr>
</table>

</br>
<div align="left"> 
  <strong>📚 Detalhes do desenvolvimento:</strong>
</div>

<div align="left"> 
   <strong>01. Utilizei a arquitetura MVP:</strong> Para deixar o projeto mais organizado e de melhor visualização, utilizei models, views e presenter(unir view e controller) para estruturar o projeto.
</div>

<div align="left"> 
   <strong>02. Apliquei os princípios de solid:</strong> Visando facilitar a manutenção do aplicativo, apliquei alguns princípios de solid, criando classes abstratas e contratos.
</div>

<div align="left"> 
   <strong>03. Utilizei o auth do Firebase integrado com o Google:</strong> Visando facilitar o login do usuário, disponibilizei o login com o Google.
</div>

<div align="left"> 
   <strong>04. Tratei os erros da api:</strong> Para melhorar a UX e a disponibilidade do aplicativo, tratei erros como a falta de internet e exibi para o usuário utilizando Toasts.
</div>

<div align="left"> 
   <strong>05. Implementei um sistema de notificação:</strong> Para lembrar os usuários de cadastrarem as rezas todos os dias, implementei a notificação no app utilizando o Firebase Messaging e um back-end que dispara as notificações todos os dias para os usuários que não cadastraram uma reza.
</div>

<div align="left"> 
   <strong>06. Criei um Ranking:</strong> Para influenciar os usuários a cadastrarem suas rezas todos os dias, criei um sistema de ranking onde é possível competir por rezas totais e rezas seguidas. Para cadastrar as rezas seguidas, criei um trigger no banco de dados, executado sempre que uma reza é cadastrada ou deletada.
</div>

<div align="left"> 
   <strong>07. Cobri o aplicativo com testes unitários:</strong> Para facilitar a manutenção do aplicativo, cobri ele com testes unitários utilizando mocks manuais e quando necessário, o mocktail.
</div>

<div align="left"> 
   <strong>08. Validei as entradas dos inputs:</strong> Visando um sistema consistente, validei as entradas dos inputs e exibi os erros para o usuário.
</div>

<br />

<div align="center">



https://github.com/LucasTKP/ipray/assets/101598532/9e101054-9fe4-4245-879f-963f33746c9d



</div>
