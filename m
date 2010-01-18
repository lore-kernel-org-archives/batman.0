Return-Path: <ylonen@gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 18 Jan 2010 12:27:06 +0100
From: =?iso-8859-1?Q?=22Juha_Yl=F6nen=22?= <ylonen@gmx.net>
Message-ID: <20100118112706.91160@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] batman-adv on different archs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

I've been trying to get my embedded project included in my mesh, but no suc=
cess yet. Could anyone give a pointers what is going wrong?

I have batman-adv compiled on my laptop, and also for testing purposes on a=
nother laptop, they see each other and everything is fine. I used the same =
sources and compiled it cleanly on each.

The problem comes when I try to add my little ARM based linux box onto the =
group. Again same sources used (latest stable from the wiki), crosscompiles=
 fine and I can load the module as normal on the box. Setup goes as it shou=
ld on both the device and the laptop, and both systems seems to be running =
smoothly. But my laptop can only see the other laptop, and the device doesn=
't see anyone. The wireless net is working and I can ping each device direc=
tly if I assign IP's to the 'real' interfaces, but through bat0 nothing is =
found. Any idea what is going wrong?

---

I've also played with the batman daemon on the device, with it I the laptop=
 and device can see each other just fine. The problem there is that apparen=
tly it doesn't really support multicast forwarding? i.e. If I have 3 device=
s A-B-C, where A does not have direct link to C (batman routes through B), =
sending a multicast from A can be received in B and vice versa, also same f=
or C-B, but no messages from A to C. Will I have the same problem with batm=
an-adv? Or can this be fixed on the daemon?

Best Regards
   Juha
--=20
GRATIS f=FCr alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
