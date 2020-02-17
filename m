Return-Path: <madhuparnabhowmik10@gmail.com>
From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Date: Mon, 17 Feb 2020 17:35:25 +0530
Subject: Re: [PATCH] net: batman-adv: Use built-in RCU list checking
Message-ID: <20200217120524.GA12888@madhuparna-HP-Notebook>
References: <20200216144718.2841-1-madhuparnabhowmik10@gmail.com>
 <1634394.jP7ydfi60B@sven-edge>
 <20200216155243.GB4542@madhuparna-HP-Notebook>
 <14125758.fD4hS3u3Vl@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14125758.fD4hS3u3Vl@sven-edge>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joel@joelfernandes.org, frextrite@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org

On Sun, Feb 16, 2020 at 05:17:36PM +0100, Sven Eckelmann wrote:
> On Sunday, 16 February 2020 16:52:44 CET Madhuparna Bhowmik wrote:
> [...]
> > > I understand this part. I was asking how you've identified them. Did you use 
> > > any tool for that? coccinelle, sparse, ...
> > 
> > Not really, I did it manually by inspecting each occurence.
> 
> In that case, I don't understand why you didn't convert the occurrences from 
> hlist_for_each_entry_rcu to hlist_for_each_entry [1]. Because a manual
> inspection should have noticed that there will always be the lock around
> these ones.
>
Hi Sven,
I have been working on similar issues (passing cond argument to
list_for_each_entry_Rcu()). That's why may be I didn't notice that in
this case rcu variant is not required.
Thank you for taking a closer look and fixing it the right way.

Regards,
Madhuparna

> KInd regards,
> 	Sven
> 
> [1] https://www.kernel.org/doc/html/v5.6-rc1/RCU/whatisRCU.html#analogy-with-reader-writer-locking


