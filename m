Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <4FF2A070.6000601@codigosur.org>
Date: Tue, 03 Jul 2012 04:34:08 -0300
From: =?UTF-8?B?Tmljb2zDoXMgRWNow6FuaXo=?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
	<4FF1CED5.3020100@gmail.com> <20120702164258.GE2917@ritirata.org>
In-Reply-To: <20120702164258.GE2917@ritirata.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman majareta? I can batctl ping but not ping
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

On 07/02/2012 01:42 PM, Antonio Quartulli wrote:
> On Mon, Jul 02, 2012 at 06:39:49PM +0200, Gioacchino Mazzurco wrote:
>> That bug was happening in Pisa some times
>> I have discussed about that antonio too
> 
> yeah, it was pretty much the same!
> I hope Guido can give us good results after testing the new patches :-)
> 
> You may want to give them a try too?? :):)

I just wanted to confirm that I've come across this bug quite often but
my setup is less tidy than guido's so it's more complex to debug.

I can add that quite recently we started in a nearby town a new WCN
project and we hit this bug the same day we put the first two nodes
online; they could bat-ping alright but no ping at all. All started
working after a reboot of one of the nodes.

Guido noted that this bug is frequently apparent when we configure a
node in some point of the mesh (an admin's home for instance) and then
move this node to it's final location.
If I get the time to do so I'll try to test if this is really the case
or just a coincidence so far.


Cheers,
NicoEchániz
