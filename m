Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 27 May 2014 16:17:39 +0200
References: <1400940034-13406-1-git-send-email-sven@narfation.org>
In-Reply-To: <1400940034-13406-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201405271617.39346.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Use memleak/error path free
	implementation of hash_resize
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
Cc: Sven Eckelmann <sven@narfation.org>

> The current implementation of hash_resize uses hash_add directly to
> initialize two a new hash table. But hash_add has two error cases: Data
> already exists and malloc fails.
> 
> The check for the duplicated data is not really harmful (beside increasing
> the time to re-add elements) but the malloc can potentially return an
> error. This malloc is unnecessary and just takes extra time and is a
> potential candidate for errors. Instead the bucket from the old hash table
> can be re-used.

Applied in revision 6bbde09.

Thanks!
    Simon
