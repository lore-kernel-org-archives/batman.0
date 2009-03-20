MIME-Version: 1.0
Date: Fri, 20 Mar 2009 13:08:22 +0100
Message-ID: <3ebdcf0a0903200508w1bdb03b8me7da995c0a31931e@mail.gmail.com>
From: Max <rey.web.mail@gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd1e906ec5ed504658bc539
Subject: [B.A.T.M.A.N.] Why in my configuration batmand works only in debug
	mode?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--000e0cd1e906ec5ed504658bc539
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thank you Marek and Marco for your suggestions.

I have solved the following problem:
>2) When launched in debug mode (using the command batmand -d 3 ath0 &), the
> daemon starts to generate OGMs and to fill up its routing tables in a
> correct way. The problem occurs when I tries to ping an host in the
network
> because the routing process uses the default routing table (that has not
> been modified by the batman daemon) and it is not aware on the correct
> batman routing tables.

Now I'm able to ping every originator in the network. The problem is derived
from some iptables filters that stop the ping. Executing the following
command I remove the filters solving the problem:

iptables --flush
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

As concern the other problem it's still present.
I'm working with meshboxes equipped with OpenWrt Kamikaze 8.09 and Atheros
WiFi Cards.
In my meshboxes, BATMAN sends OGMs only when it's launched in debug mode
using the command
"batmand -d 3 ath0 &". In this case, I see OGMs travelling in the network
using Wireshark and the command "ip route ls table 66" lists all reachable
batman nodes. Also for the other debug levels (i.e. 1,2,4,5) batmand works
properly.

On the other hand, when I launch the daemon in normal mode, using the
command "batmand ath0", no error is displayed but no OGMs is observed to be
travelling in the network using Wireshark. The only message displayed is:
"Interface activated: ath0
Using interface ath0 with address 10.0.0.1 and broadcast address
10.255.255.255"

Also the command "ip route ls table 66" does not produce any output.

This morning I've installed the last version named B.A.T.M.A.N. 0.3.2-beta
rv1235 (compatibility version 5) but I face again with the same problem.

And finally another question...
Is it normal to observe 3 different processes named batmand using the shell
command ps even if I launched the daemon only once?


Thank you in advance!

Best regards,
Massimo

--000e0cd1e906ec5ed504658bc539
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you Marek and Marco for your suggestions.<br><br>I have solved the fo=
llowing problem:<div class=3D"im"><br>&gt;2) When launched in debug mode (u=
sing the command batmand -d 3 ath0 &amp;), the<br>
&gt; daemon starts to generate OGMs and to fill up its routing tables in a<=
br>
&gt; correct way. The problem occurs when I tries to ping an host in the ne=
twork<br>
&gt; because the routing process uses the default routing table (that has n=
ot<br>
&gt; been modified by the batman daemon) and it is not aware on the correct=
<br>
&gt; batman routing tables.<br><br></div>Now
I&#39;m able to ping every originator in the network. The problem is
derived from some iptables filters that stop the ping. Executing the
following command I remove the filters solving the problem:<br>
<br>iptables --flush<br>iptables -F<br>iptables -X<br>iptables -t nat -F<br=
>iptables -t nat -X<br>iptables -t mangle -F<br>iptables -t mangle -X<br>ip=
tables -P INPUT ACCEPT<br>iptables -P FORWARD ACCEPT<br>iptables -P OUTPUT =
ACCEPT<br>

<br>As concern the other problem it&#39;s still present.<br>I&#39;m working=
 with meshboxes equipped with OpenWrt Kamikaze 8.09 and Atheros WiFi Cards.=
<br>In my meshboxes, BATMAN sends OGMs only when it&#39;s launched in debug=
 mode using the command <br>
&quot;batmand
-d 3 ath0 &amp;&quot;. In this case, I see OGMs travelling in the network
using Wireshark and the command &quot;ip route ls table 66&quot; lists all
reachable batman nodes. Also for the other debug levels (i.e. 1,2,4,5) batm=
and works properly.<br>
<br>On the other hand, when I launch the daemon in normal mode, using the c=
ommand &quot;batmand
ath0&quot;, no error is displayed but no OGMs is observed to be travelling
in the network using Wireshark. The only message displayed is:<br>&quot;Int=
erface activated: ath0<br>
Using interface ath0 with address 10.0.0.1 and broadcast address 10.255.255=
.255&quot;<br><br>Also the command &quot;ip route ls table 66&quot; does no=
t produce any output.<br><br>This morning I&#39;ve installed the last versi=
on named B.A.T.M.A.N. 0.3.2-beta rv1235 (compatibility version 5) but I fac=
e again with the same problem.<br>
<br>And finally another question...<br>Is it normal to observe 3 different =
processes named batmand using the shell command ps even if I launched the d=
aemon only once?<br>
<br><br>Thank you in advance!<br><br>Best regards,<br>Massimo

--000e0cd1e906ec5ed504658bc539--
