Return-Path: <ordex@autistici.org>
Date: Sun, 4 Dec 2011 11:35:50 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111204103550.GA20976@ritirata.org>
References: <1322945658-25154-1-git-send-email-ordex@autistici.org>
	<201112041736.43389.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201112041736.43389.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: in case of roaming mark the
 client with TT_CLIENT_ROAM
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

On Sun, Dec 04, 2011 at 05:36:43 +0800, Marek Lindner wrote:
> On Sunday, December 04, 2011 04:54:18 Antonio Quartulli wrote:
> > Whenever we add a local client for which we already have a global entry,
> > the latter has to be marked with the TT_CLIENT_ROAM flag (instead of
> > TT_CLIENT_PENDING)
> 
> Am I right that this patch should go into linux 3.2 ? Maybe even to stable ? 
> If so, which versions ? linux 3.0 and linux 3.1 ?
> Are there more patches for stable from your end ? I'd like to send them in one 
> go and not one by one ..

Actually I would send it to stable-3.1.

Please, give me 12hours more for the other patches. I'll work on them later
today.

Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
