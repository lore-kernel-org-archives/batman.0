Message-ID: <5635aa0d0811040639m4e1b34bci4fd368dc7f92a4be@mail.gmail.com>
Date: Tue, 4 Nov 2008 21:39:31 +0700
From: "Outback Dingo" <outbackdingo@gmail.com>
Subject: Re: [B.A.T.M.A.N.] BMX problem in r1138 with client node and tun
In-Reply-To: <d5bba6ce0811040637r2c7c267ap3ab1de99d91a06c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_39364_29653105.1225809571175"
References: <d5bba6ce0810251333r67247a0cpaf164be0e33b0f38@mail.gmail.com>
	<200810292133.58495.axel@open-mesh.net>
	<d5bba6ce0811031526y6073839eibd9b8c486b9178e6@mail.gmail.com>
	<200811041044.29172.axel@open-mesh.net>
	<d5bba6ce0811040637r2c7c267ap3ab1de99d91a06c6@mail.gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

------=_Part_39364_29653105.1225809571175
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

be nice if someone updated the OpenWRT port as the Make file appears broken
now on 1138 up

On Tue, Nov 4, 2008 at 9:37 PM, Julio Cesar Puigpinos <jcpuigpinos@gmail.com
> wrote:

> 2008/11/4 Axel Neumann :
> > Hi,
>
> Hi
>
> > On Dienstag 04 November 2008, Julio Cesar Puigpinos wrote:
> > [...]
> >> Well, after several (and painfull :) ) tests we could determinate 2
> >> scenarios: 1) BMX started like this "bmxd -o 2000 -g 5000 ath2", it
> didn't
> >
> > THANX a lot for your painfull testing! That was the tip. I was not aware
> that
> > forking to backgound after launching a new thread is so problematic. And
> > because i forgot that my initscripts on the foneras always added -d3 and
> >>/dev/zero & to the commandline the problem never appeared. Should be
> fixed
> > with rv1148.
>
> YW, it was worth.
>
> I've tested r1148 and is working :)
>
> This saturday we're gonna test it deeply with Nightwing.
>
> > best regards,
> > axel
>
>                    Saludos, Julio
>
> --
> www.lugro-mesh.org.ar/        Wireless Mesh Networks Group
> www.lugro.org.ar                         GNU/Linux User Group Rosario,
> Argentina
> Slackware rulez :P             www.slackware.org
> NO A LA MATRICULA!!!: http://noalamatricula.wordpress.com/
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

------=_Part_39364_29653105.1225809571175
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

be nice if someone updated the OpenWRT port as the Make file appears broken now on 1138 up<br><br><div class="gmail_quote">On Tue, Nov 4, 2008 at 9:37 PM, Julio Cesar Puigpinos <span dir="ltr">&lt;<a href="mailto:jcpuigpinos@gmail.com">jcpuigpinos@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">2008/11/4 Axel Neumann :<br>
&gt; Hi,<br>
<div class="Ih2E3d"><br>
Hi<br>
<br>
&gt; On Dienstag 04 November 2008, Julio Cesar Puigpinos wrote:<br>
&gt; [...]<br>
&gt;&gt; Well, after several (and painfull :) ) tests we could determinate 2<br>
&gt;&gt; scenarios: 1) BMX started like this &quot;bmxd -o 2000 -g 5000 ath2&quot;, it didn&#39;t<br>
&gt;<br>
&gt; THANX a lot for your painfull testing! That was the tip. I was not aware that<br>
&gt; forking to backgound after launching a new thread is so problematic. And<br>
&gt; because i forgot that my initscripts on the foneras always added -d3 and<br>
&gt;&gt;/dev/zero &amp; to the commandline the problem never appeared. Should be fixed<br>
&gt; with rv1148.<br>
<br>
</div>YW, it was worth.<br>
<br>
I&#39;ve tested r1148 and is working :)<br>
<br>
This saturday we&#39;re gonna test it deeply with Nightwing.<br>
<br>
&gt; best regards,<br>
&gt; axel<br>
<div class="Ih2E3d"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Saludos, Julio<br>
<br>
--<br>
<a href="http://www.lugro-mesh.org.ar/" target="_blank">www.lugro-mesh.org.ar/</a> &nbsp; &nbsp; &nbsp; &nbsp;Wireless Mesh Networks Group<br>
<a href="http://www.lugro.org.ar" target="_blank">www.lugro.org.ar</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; GNU/Linux User Group Rosario, Argentina<br>
Slackware rulez :P &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="http://www.slackware.org" target="_blank">www.slackware.org</a><br>
NO A LA MATRICULA!!!: <a href="http://noalamatricula.wordpress.com/" target="_blank">http://noalamatricula.wordpress.com/</a><br>
_______________________________________________<br>
</div><div><div></div><div class="Wj3C7c">B.A.T.M.A.N mailing list<br>
<a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</div></div></blockquote></div><br>

------=_Part_39364_29653105.1225809571175--
