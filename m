Return-Path: <ordex@autistici.org>
Date: Fri, 25 Nov 2011 11:53:49 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111125105349.GA17321@autistici.org>
References: <1322044544-15153-1-git-send-email-ordex@autistici.org>
	<201111250908.48180.lindner_marek@yahoo.de>
	<1462592.m5CKka3Otj@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1462592.m5CKka3Otj@sven-laptop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add biggest_unsigned_int(x)
 macro
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

On Fri, Nov 25, 2011 at 09:50:41AM +0100, Sven Eckelmann wrote:
> On Friday 25 November 2011 09:08:47 Marek Lindner wrote:
> [...]
> > > +/* Returns the biggest unsigned integer with the sizeof x */
> > > +#define biggest_unsigned_int(x) (~(x)0)
> > > +
> > 
> > The final conclusion of the IRC discussion might have escaped me but wasn't
> > there supposed to be a cast somewhere ?
> 
> There is a cast. The part "(x)" of "(~(x)0)" is the cast. And I don't think 
> that there was a final conclusion. I am not really convinced that this should 
> be part of batman-adv. Just look at include/linux/kernel.h for similar 
> functionality (but with predefined types). Maybe this would be the correct 
> position for such a macro? (I don't know it... just thinking out loud).

Might be a good idea to send it to the kernel ml, but as usual, I think
we should first include it in the batman-adv code (am I wrong or we are
still waiting for seq_before/after to be included somewhere?).

But I agree with you, I should also send this patch to the kerel ml.

Cheers,


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara ☭
