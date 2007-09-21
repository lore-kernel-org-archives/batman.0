Message-ID: <46faed20709211041m2b872bcel2c4636e13ad5b092@mail.gmail.com>
Date: Fri, 21 Sep 2007 19:41:54 +0200
From: "Steven Leeman" <steven@leeman.be>
Sender: steven.leeman@gmail.com
Subject: Re: [B.A.T.M.A.N.] assigned IP life
In-Reply-To: <38681.85.41.146.90.1190394295.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_32373_31918411.1190396514710"
References: <38681.85.41.146.90.1190394295.squirrel@krisma.oltrelinux.com>
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

------=_Part_32373_31918411.1190396514710
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

1sec dhcp releases? so it worsened?

on 3 september i noticed they were only 2 minutes long....my skype sessions
got even disconnected everytime...
and it took some time to reconnect ...
a wget of a 1mbyte file was even impossible

Ethernet adapter Local Area Connection:

        Connection-specific DNS Suffix  . :
        Description . . . . . . . . . . . : LevelOne 32/64-Bit Gigabit
Ethernet
Adapter
        Physical Address. . . . . . . . . : 00-11-6B-35-4A-FA
        Dhcp Enabled. . . . . . . . . . . : Yes
        Autoconfiguration Enabled . . . . : Yes
        IP Address. . . . . . . . . . . . : 10.59.132.100
        Subnet Mask . . . . . . . . . . . : 255.255.255.0
        Default Gateway . . . . . . . . . : 10.59.132.1
        DHCP Server . . . . . . . . . . . : 10.59.132.1
        DNS Servers . . . . . . . . . . . : 151.99.125.2
        Lease Obtained. . . . . . . . . . : zondag 2 september 2007 10:35:12
---> he just got a new lease again due to these dhcp boot?
        Lease Expires . . . . . . . . . . : zondag 2 september 2007 10:37:12
-> a short dhcp leases might be the cause...


2007/9/21, a.anselmi@oltrelinux.com <a.anselmi@oltrelinux.com>:
>
> Hi
> mybe these lines form -d3 level at client node 5.1.7.251 can help:
>
> Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
> Gateway client - gateway (5.1.7.254) says: IP (1.0.254.169) is expired
> Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
> Gateway client - gateway (5.1.7.254) says: IP (1.0.254.169) is expired
> Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
> Gateway client - gateway (5.1.7.254) says: IP (1.0.254.169) is expired
> Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
> Gateway client - disconnecting from unresponsive gateway: 5.1.7.254
> Deleting default route via bat0 0.0.0.0 (table 67)
> -- after some seconds --
> Adding default route to 5.1.7.254 (49,64,64)
> Adding default route via bat0 0.0.0.0 (table 67)
>
> ...seems that lease assigned by gateway to client (IP 1.0.254.169) have a
> less than 1 sec of life... almost in my case.
>
> Antonio
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

------=_Part_32373_31918411.1190396514710
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

1sec dhcp releases? so it worsened?<br><br>on 3 september i noticed they were only 2 minutes long....my skype sessions got even disconnected everytime...<br>and it took some time to reconnect ...<br>a wget of a 1mbyte file was even impossible
<br><br>Ethernet adapter Local Area Connection:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection-specific DNS Suffix&nbsp; . :<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Description . . . . . . . . . . . : LevelOne 32/64-Bit Gigabit Ethernet<br>Adapter<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Physical Address. . . . . . . . . : 00-11-6B-35-4A-FA
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dhcp Enabled. . . . . . . . . . . : Yes<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Autoconfiguration Enabled . . . . : Yes<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP Address. . . . . . . . . . . . : <a href="http://10.59.132.100/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
10.59.132.100</a><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subnet Mask . . . . . . . . . . . : 
<a href="http://255.255.255.0/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">255.255.255.0</a><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Default Gateway . . . . . . . . . : <a href="http://10.59.132.1/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
10.59.132.1</a><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DHCP Server . . . . . . . . . . . : <a href="http://10.59.132.1/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">10.59.132.1
</a><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DNS Servers . . . . . . . . . . . : <a href="http://151.99.125.2/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">151.99.125.2</a><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Lease Obtained. . . . . . . . . . : zondag 2 september 2007 10:35:12
---&gt; he just got a new lease again due to these dhcp boot?
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Lease Expires . . . . . . . . . . : zondag 2 september 2007 10:37:12 -&gt; a short dhcp leases might be the cause...<br><br><br><div><span class="gmail_quote">2007/9/21, <a href="mailto:a.anselmi@oltrelinux.com">
a.anselmi@oltrelinux.com</a> &lt;<a href="mailto:a.anselmi@oltrelinux.com">a.anselmi@oltrelinux.com</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi<br>mybe these lines form -d3 level at client node <a href="http://5.1.7.251">5.1.7.251</a> can help:<br><br>Gateway client - got IP (<a href="http://1.0.254.169">1.0.254.169</a>) from gateway: <a href="http://5.1.7.254">
5.1.7.254</a><br>Gateway client - gateway (<a href="http://5.1.7.254">5.1.7.254</a>) says: IP (<a href="http://1.0.254.169">1.0.254.169</a>) is expired<br>Gateway client - got IP (<a href="http://1.0.254.169">1.0.254.169</a>
) from gateway: <a href="http://5.1.7.254">5.1.7.254</a><br>Gateway client - gateway (<a href="http://5.1.7.254">5.1.7.254</a>) says: IP (<a href="http://1.0.254.169">1.0.254.169</a>) is expired<br>Gateway client - got IP (
<a href="http://1.0.254.169">1.0.254.169</a>) from gateway: <a href="http://5.1.7.254">5.1.7.254</a><br>Gateway client - gateway (<a href="http://5.1.7.254">5.1.7.254</a>) says: IP (<a href="http://1.0.254.169">1.0.254.169
</a>) is expired<br>Gateway client - got IP (<a href="http://1.0.254.169">1.0.254.169</a>) from gateway: <a href="http://5.1.7.254">5.1.7.254</a><br>Gateway client - disconnecting from unresponsive gateway: <a href="http://5.1.7.254">
5.1.7.254</a><br>Deleting default route via bat0 <a href="http://0.0.0.0">0.0.0.0</a> (table 67)<br>-- after some seconds --<br>Adding default route to <a href="http://5.1.7.254">5.1.7.254</a> (49,64,64)<br>Adding default route via bat0 
<a href="http://0.0.0.0">0.0.0.0</a> (table 67)<br><br>...seems that lease assigned by gateway to client (IP <a href="http://1.0.254.169">1.0.254.169</a>) have a<br>less than 1 sec of life... almost in my case.<br><br>Antonio
<br><br><br>_______________________________________________<br>B.A.T.M.A.N mailing list<br><a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br><a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n">
https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br></blockquote></div><br>

------=_Part_32373_31918411.1190396514710--
