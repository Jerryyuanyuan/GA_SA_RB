function  sentMail( sendtoaddress,fujian)
%SENTMAIL Summary of this function goes here
%   Detailed explanation goes here
myaddress = 'xiaoqiangdeyou@sina.com';%����ط���Ҫ�����Լ������䣬�Ҿٸ����Ӷ��ѣ������������������ǿ�����smpt����ģ�
mypassword = '2639114';%�������������룡
setpref('Internet','E_mail',myaddress);
setpref('Internet','SMTP_Server','smtp.sina.com');%����ط�����ø��������Ϊ�����163���䣬��ط�����smpt.163.com�����ǣ���������������뿪����smpt����
setpref('Internet','SMTP_Username',myaddress);
setpref('Internet','SMTP_Password',mypassword);

props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', ...
                  'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','8090');

sendmail(sendtoaddress, 'test mail', 'i love you!',fujian)%�������������������ط���ֻҪ���������ʼ����У�
end

