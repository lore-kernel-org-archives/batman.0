Return-Path: <plettpc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201106191309.01399.lindner_marek@yahoo.de>
References: <BANLkTi=1-+rypSNN-GJvi1rCh_W_SCVH0w@mail.gmail.com>
	<201106191309.01399.lindner_marek@yahoo.de>
Date: Sun, 19 Jun 2011 13:39:06 +0200
Message-ID: <BANLkTi=3o4mFyrRnVo8WZF5gCejzFVPGCQ@mail.gmail.com>
From: wayne abroue <plettpc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Sun, Jun 19, 2011 at 1:09 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:
>
> Hi,
>
>> I'm trying to interogate vis on a bat-adv server node, Can anybody
>> point me in the right direction, It's for use with this
>> http://villagetelco.org/2011/06/spud-simple-unified-dashboard-for-mesh-netw
>> orks/ It works with batman, but not with bat-adv.
>
> unlike batmand (our layer 3 implementation) batman-adv has the vis server
> built-in. Using the layer 3 vis server on top of batman-adv won't help you.
>
> Please read our documentation regarding the layer 2 vis server first and feel
> free to come back with any questions you might have:
> http://www.open-mesh.org/wiki/batman-adv/VisAdv
>
> Regards,
> Marek
>

Thanks Marek, I get this, and vis is working internally in my bat-adv
environment, What this implementation is trying to do is monitor the
vis from outside the mesh, thus my question?
How could this be achieved?

Wayne
