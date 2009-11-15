Return-Path: <public@plane.gmane.org>
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
References: <20091109190206.GA2642@Linus-Debian>
	<200911101834.41970.lindner_marek@yahoo.de>
	<20091112005149.GA2879@Linus-Debian>
Date: Sun, 15 Nov 2009 18:08:43 +0100
In-Reply-To: <20091112005149.GA2879@Linus-Debian> ("Linus =?iso-8859-1?Q?L?=
	=?iso-8859-1?Q?=FCssing=22's?= message
	of "Thu, 12 Nov 2009 01:51:49 +0100")
Message-ID: <87fx8fvhpg.fsf@trurl.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [B.A.T.M.A.N.] BATMAN-Adv and MTU handling
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <public-b.a.t.m.a.n-ZwoEplunGu2X36UT3dwlltHuzzzSOjJt@plane.gmane.org>



>> I think you underestimate the performance impact. AFAIK IPv6 does not
>> support the clasical IPv4 fragmentation anymore (intermediate routers
>> won't fragment the packets but drop them).

> Hmm, yes, true, IPv6 does not support fragmentation at all...

It does, but it's done end-to-end, not at intermediate routers.  See
Section 5 of RFC 2460.

                                        Juliusz

