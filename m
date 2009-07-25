Return-Path: <sophana78@gmail.com>
MIME-Version: 1.0
Date: Sun, 26 Jul 2009 01:32:52 +0200
Message-ID: <f7dbe3920907251632q24bde7c0w87dee1eb009f4520@mail.gmail.com>
From: Sophana K <sophana78@gmail.com>
Content-Type: multipart/alternative; boundary=001636c5b1f4c2f015046f9023de
Subject: [B.A.T.M.A.N.] [batman-advanced]beginner questions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: B.A.T.M.A.N@lists.open-mesh.net

--001636c5b1f4c2f015046f9023de
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

I've read the readme on how to setup batman advanced and also the openwrt
howto.
It looks great, and it looks like the way to go as roaming seem to be
handled correctly.
I have some questions before I try to setup it.

Could it work on "standard" broadcom hardware like WRT54gl?
Do I need multi ssid hardware? only atheros?
What about the ahdemo mode? is it like adhoc?
If I want standard AP mode, must I create several ssid (1 ahdemo + 1 AP)
then bridge bat0 to the AP ssid?

If I want to setup coova-chilli to drive the mesh (hotspot mesh), how could
I ssh to the repeaters? Is some sort of VLAN supported? there would be 2
separate networks in the mesh, one for gateway to repeater communication,
the other for the hotspot mesh.
Or maybe would it be possible that repeaters use a specific dhcp server (not
chilli) to get their ip addresses?
It looks that we can get the mac addresses of all repeaters. Can I use arp
to get their IP?
You would say "why ssh to the repeaters?", I don't know... Maybe for
configuration/ monitoring...

Thanks

--001636c5b1f4c2f015046f9023de
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br>I&#39;ve read the readme on how to setup batman advanced and also=
 the openwrt howto.<br>It looks great, and it looks like the way to go as r=
oaming seem to be handled correctly.<br>I have some questions before I try =
to setup it.<br>
<br>Could it work on &quot;standard&quot; broadcom hardware like WRT54gl?<b=
r>Do I need multi ssid hardware? only atheros?<br>What about the ahdemo mod=
e? is it like adhoc?<br>If I want standard AP mode, must I create several s=
sid (1 ahdemo + 1 AP) then bridge bat0 to the AP ssid?<br>
<br>If I want to setup coova-chilli to drive the mesh (hotspot mesh), how c=
ould I ssh to the repeaters? Is some sort of VLAN supported? there would be=
 2 separate networks in the mesh, one for gateway to repeater communication=
, the other for the hotspot mesh. <br>
Or maybe would it be possible that repeaters use a specific dhcp server (no=
t chilli) to get their ip addresses?<br>It looks that we can get the mac ad=
dresses of all repeaters. Can I use arp to get their IP?<br>You would say &=
quot;why ssh to the repeaters?&quot;, I don&#39;t know... Maybe for configu=
ration/ monitoring...<br>
<br>Thanks<br><br>

--001636c5b1f4c2f015046f9023de--
