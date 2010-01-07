Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 7 Jan 2010 13:23:28 +0800
References: <20091231033752.GA18781@Sellars>
	<201001030326.02365.lindner_marek@yahoo.de>
	<20100105042058.GA3102@Linus-Debian>
In-Reply-To: <20100105042058.GA3102@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201001071323.28234.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: atomic variable for
	vis-srv activation
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Tuesday 05 January 2010 12:20:58 Linus L=FCssing wrote:
> Hmm, so far we are having too modes only, vis server being enabled
> or disabled. But in those packet functions we are talking about
> types (two ones only so far again) instead. In the second one I found it
> ok to use the defines, but for the proc.c switching, I found a
> simple 0 or 1 more intuitive, as you already know that this
> function is for enabling/disabling the vis server and you don't
> have to wonder about a certain vis-types field in the vis-packet
> format. Hmm, I'm also wondering, are there any plans for
> introducing other vis_types? (What would you think about changing
> the 8 bits vis_type field to flags instead?)

I think using defines instead of hard-coded values always is the better cho=
ice.=20
Even if it is more intuitive for you now you never know when this code is=20
going to be extended. In addition, you still want to understand the code in=
 6=20
months and/or make it easier of others to understand.

Whether it makes sense to rename more variables / defines is another discus=
sion=20
and belongs into another patch. :)


> Damn it, you are right :). I assume, that it'd be ok to remove the default
> value being set in vis_init and explicitly setting this field
> every time a new vis packet gets generated in generate_vis_packet()
> (instead of updating this variable from proc.c too)?

I think a default value is good to have.  ;-)
generate_vis_packet() looks like a good place to update the packet's variab=
le.


> Yes, sorry, you're right I'd removed the
> server/client/enabled/disabled things and added just 0/1 as input
> values for proc to make the syntax similar to the aggregation
> stuff and simple in general for the kernel module. I'm going to put
> that in a seperate patch.

Great.

Regards,
Marek
