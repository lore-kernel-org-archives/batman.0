Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1497356708.31945.7.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Tue, 13 Jun 2017 14:25:08 +0200
In-Reply-To: <1765005.rRRDaVj5Ib@bentobox>
References: <20170613103916.27299-1-philipp.psurek@gmail.com>
 <2394098.zSA1hTeZKT@prime> <2063591.f2Dj0aj4GU@bentobox>
 <1765005.rRRDaVj5Ib@bentobox>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: suppress implicit-fallthrough
 compiler warning
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Am Dienstag, den 13.06.2017, 13:53 +0200 schrieb Sven Eckelmann:
> The other option would have been to change it to:
> 
>     /* fall through - print the partial result */

Thank you Sven for pointing this out. This one works perfectly! Regex
understanding 4TW ;-)

Thank you Simon for restyling the patch.

Batctl compiles now without any warnings with GCC 7.1.0. I’m surprised
how far it has come: the compiler inspects comments now …

Thank you all for B.A.T.M.A.N.-Advanced

Best regards,

Philipp
