Return-Path: <plettpc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20110619194119.GB30791@pandem0nium>
References: <BANLkTi=1-+rypSNN-GJvi1rCh_W_SCVH0w@mail.gmail.com>
	<201106191309.01399.lindner_marek@yahoo.de>
	<BANLkTi=3o4mFyrRnVo8WZF5gCejzFVPGCQ@mail.gmail.com>
	<20110619194119.GB30791@pandem0nium>
Date: Mon, 20 Jun 2011 10:04:22 +0200
Message-ID: <BANLkTi=hr0bmH8G8G8X3AvqWq7XquOvbBQ@mail.gmail.com>
From: wayne abroue <plettpc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Vis server
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sun, Jun 19, 2011 at 9:41 PM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> Hello Wayne,
>
> if you want access from outside the mesh, you should set up one of the me=
sh nodes
> to share information, e.g.:
>
> =A01.) set up a netcat server which constantly runs "batctl vd dot"
> =A02.) periodically (or on demand?) ssh in to a mesh node which
>
> We have used solution 1 for meshs3d and it works quite fine. It will give=
 you pretty
> much the same behaviour as the old vis server.
>
> Regards,
> =A0 =A0 =A0 =A0Simon
>
Thanks Simon
Yes, I will try also to modify the PHP, maybe using PHP to log in
using SSH and exec the cmd.
I'll try to get the Dev, to modify if I don't get it right, SPUD II,
for bat-adv sounds good!
Here's a working model running batmand.
http://villagetelco.org/2011/06/spud-simple-unified-dashboard-for-mesh-netw=
orks/

Wayne
