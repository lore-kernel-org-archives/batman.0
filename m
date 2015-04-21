Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Apr 2015 11:37:37 +0200
Message-ID: <2772516.LYURaBhBM1@bentobox>
In-Reply-To: <1429605763-17186-1-git-send-email-sven@narfation.org>
References: <1429605763-17186-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 1/2] batman-adv: Remove dynamically
	allocated hashtables
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On Tuesday 21 April 2015 10:42:42 Sven Eckelmann wrote:
> It is unnecessary to allocate an extra memory region for hashtables and the
> corresponding locks. This brings the hashes used in batman-adv slightly in
> the direction of the common statically sized hash table implementation.
> More common hashtable functionality cannot be used batman-adv wide because
> the simple hashtable and rhashtable implementations don't provide bucket
> based locking.

I was now informed that the rhashtable can now (Linux 4.0) support per bucket 
locks. The last statement is therefore wrong since the last Linux release.

Kind regards,
	Sven
