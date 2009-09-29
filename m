Return-Path: <jacobmarble@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200909291719.37794.lindner_marek@yahoo.de>
References: <200909031406.49008.lindner_marek@yahoo.de>
	<5161afcd0909282206w7e412a8ak3c9f5ad1f5ab878a@mail.gmail.com>
	<20090929052511.GZ16067@lunn.ch>
	<200909291719.37794.lindner_marek@yahoo.de>
Date: Tue, 29 Sep 2009 09:56:56 -0600
Message-ID: <5161afcd0909290856w41dc1d10l3b109c2e68155f70@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] mailing list migration (was: development flow)
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Tue, Sep 29, 2009 at 3:19 AM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> Ok, if this list is not going to make it I only see 2 options (feel free to
> add more):
>
> * We drop the requirement to keep the domain name for the list and migrate
> everyone to the new list.
> * We create the additional new list while keeping the old one. The new list is
> for the communication with the kernel developers.
>
> Opinions ?

I think that having two lists would be a hassle and a mistake.  To
have two lists at one host might work, but one list at VGER and
another somewhere else could be counter-productive, as "internal"
communication would be constantly forwarded to the kernel list, and
relevant kernel traffic would have to be forwarded back to the
"internal" list.  Think about that for a second.  Eventually, we would
probably just drop one list.

If one list is O(n), then two lists are O(n^2) for anyone who needs
both.  I vote for one list, no matter where it's hosted.

commercial solution (EMWD):
 - spam filtering
 - open-mesh.net
 - small price < US$20/month

open source host (VGER, freelists.org)
 - spam filtering
 - their-domain.com
 - no price
 - we get added to their project directory, so potential contributors see us

Jake
