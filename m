MIME-Version: 1.0
In-Reply-To: <200905231230.16394.lindner_marek@yahoo.de>
References: <1242937180.14711.14.camel@turing.asconix.lan>
	<200905231230.16394.lindner_marek@yahoo.de>
Date: Sat, 23 May 2009 09:40:15 +0200
Message-ID: <8502079e0905230040q775277b5g71866bf362f2fb20@mail.gmail.com>
From: Christoph Pilka <christoph.pilka@googlemail.com>
Content-Type: multipart/alternative; boundary=000e0cd25048e44164046a8f7c21
Subject: Re: [B.A.T.M.A.N.] VIS server for batman-adv-kernelland
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

--000e0cd25048e44164046a8f7c21
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

Hi* You are splitting up the VLANs and I did not quite get the reason. In
> the
> document you state the number of OGMs will be decreased. Whether it
> decreases
> or not heavily depends on the network attached to these VLANs. How does the
> topology look like ? May be I overlooked that section ?
>

Well, I didn't mention it, but the reason for splitting the lan ports into
VLANs is an approach for using bat-adv on boxes in a partially wired
environment (indoor installations with some ethernet wires). So, yepp,
you're right, it depends on the network topology. In my case I am using some
of the LAN connections to link the boxes among each other. So I think, it's
a good approach to seperate the lan ports and to let bat-adv bridge the
frames. Correct me, if it's wrong.

* The vis-advanced daemon is not necessary here because the kernel module
> has
> the server built-in. All you need to do is activating a server (echo
> "server"
> > /proc/net/batman-adv/vis) which allows you to retrieve the information
> via
> cat /proc/net/batman-adv/vis. The vis-advanced daemon goes together with
> batman-adv-userspace which is the user space implementation of the layer 2
> approach. Its a bit confusing - we have to think about how to clean it up
> ..
>

Yepp, you're right. I've documented the vis stuff beeing not sure if it's
working this way on layer 2. Simon answered all of my questions so now it's
time for me to write down the bat-adv-kernel way ;-) He gave me some very
interesting hints to collect the data from outside the mesh like polling
/proc/net/batman-adv/vis. I think it's a good challenge for me for this
weekend to set up a nice solution to collect the data on a central box
outside the mesh and visualize it. I have some experiences with JSON, so
Iwould use it as exchange format. Well, patching s3d to accept MAC- instead
of IP-addresses seems to be a nice solution too.

Regards,
Chris

-- 
"Privacy in residential applications is a desirable marketing option." (ETSI
EN 300 175-7 Ch. A6)

--000e0cd25048e44164046a8f7c21
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><span dir=3D"ltr"></span><br><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi* You are splitting up the VLANs and I did not quite get the reason. In t=
he<br>
document you state the number of OGMs will be decreased. Whether it decreas=
es<br>
or not heavily depends on the network attached to these VLANs. How does the=
<br>
topology look like ? May be I overlooked that section ?<br>
</blockquote><div><br>Well, I didn&#39;t mention it, but the reason for spl=
itting the lan ports into VLANs is an approach for using bat-adv on boxes i=
n a partially wired environment (indoor installations with some ethernet wi=
res). So, yepp, you&#39;re right, it depends on the network topology. In my=
 case I am using some of the LAN connections to link the boxes among each o=
ther. So I think, it&#39;s a good approach to seperate the lan ports and to=
 let bat-adv bridge the frames. Correct me, if it&#39;s wrong. <br>
<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
* The vis-advanced daemon is not necessary here because the kernel module h=
as<br>
the server built-in. All you need to do is activating a server (echo &quot;=
server&quot;<br>
&gt; /proc/net/batman-adv/vis) which allows you to retrieve the information=
 via<br>
cat /proc/net/batman-adv/vis. The vis-advanced daemon goes together with<br=
>
batman-adv-userspace which is the user space implementation of the layer 2<=
br>
approach. Its a bit confusing - we have to think about how to clean it up .=
.<br>
</blockquote><div><br>Yepp, you&#39;re right. I&#39;ve documented the vis s=
tuff beeing not sure if it&#39;s working this way on layer 2. Simon answere=
d all of my questions so now it&#39;s time for me to write down the bat-adv=
-kernel way ;-) He gave me some very interesting hints to collect the data =
from outside the mesh like polling /proc/net/batman-adv/vis. I think it&#39=
;s a good challenge for me for this weekend to set up a nice solution to co=
llect the data on a central box outside the mesh and visualize it. I have s=
ome experiences with JSON, so Iwould use it as exchange format. Well, patch=
ing s3d to accept MAC- instead of IP-addresses seems to be a nice solution =
too. <br>
<br>Regards,<br>Chris<br><br></div></div>-- <br>&quot;Privacy in residentia=
l applications is a desirable marketing option.&quot; (ETSI EN 300 175-7 Ch=
. A6)<br><br>

--000e0cd25048e44164046a8f7c21--
