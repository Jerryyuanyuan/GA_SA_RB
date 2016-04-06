function  sentMail( sendtoaddress,fujian)
%SENTMAIL Summary of this function goes here
%   Detailed explanation goes here
myaddress = 'xiaoqiangdeyou@sina.com';%这个地方你要输入自己的邮箱，我举个例子而已！但是你这个邮箱必须是开启了smpt服务的！
mypassword = '2639114';%输入该邮箱的密码！
setpref('Internet','E_mail',myaddress);
setpref('Internet','SMTP_Server','smtp.sina.com');%这个地方你最好搞清楚，因为如果是163邮箱，这地方就是smpt.163.com，但是！！你的这个邮箱必须开启了smpt服务
setpref('Internet','SMTP_Username',myaddress);
setpref('Internet','SMTP_Password',mypassword);

props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', ...
                  'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','8090');

sendmail(sendtoaddress, 'test mail', 'i love you!',fujian)%可以是随意的邮箱这个地方，只要你能验收邮件就行！
end

