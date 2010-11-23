Return-Path: <linus.luessing@ascom.ch>
Date: Tue, 23 Nov 2010 10:50:42 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@ascom.ch>
Message-ID: <20101123095042.GA24148@Sellars>
References: <1290462354-17246-1-git-send-email-linus.luessing@ascom.ch>
	<201011230044.58352.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201011230044.58352.lindner_marek@yahoo.de>
Sender: linus.luessing@ascom.ch
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Fix bisecting of OGMs with
 32bit seqno
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

On Tue, Nov 23, 2010 at 12:44:57AM +0100, Marek Lindner wrote:
> On Monday 22 November 2010 22:45:53 Linus Lüssing wrote:
> > -static int seqno_event_new(char *iface_addr, char *orig, char
> > *prev_sender, char *neigh, int seqno, int tq, int ttl) +static int
> > seqno_event_new(char *iface_addr, char *orig, char *prev_sender, char
> > *neigh, int64_t seqno, int tq, int ttl)
> 
> Didn't you forget to adjust the seqno size in the seqno_event and seqno_trace 
> struct ? Simply declaring it 64bit in the function header won't do much good 
> ...
> 
> Regards,
> Marek
>
Urgh, just noticed, that there seem to be even more places that
need to be modified. E.g. all those seqno_min and seqno_max
occurences or strtol probably needs to be stroll for the seqno,
too. Using int64_t for any seqno(_min/max) occurence probably
won't be sufficient either, as then printf()s for int64_t (even
with %lld) won't be so nice, I guess.

Do you think using long long instead of ints for the seqnos is ok
(without any int64_t usage), hoping that on every architecture a
long long will be at least 8 Bytes large?

Cheers, Linus
