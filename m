Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 12 Oct 2011 17:24:41 +0200
References: <1317823294-16922-1-git-send-email-ordex@autistici.org>
	<1317827125-22776-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1317827125-22776-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201110121724.42282.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: fixed hash functions type
	to uint32_t instead of int
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

On Wednesday, October 05, 2011 17:05:25 Antonio Quartulli wrote:
> There are two reasons for this fix:
> - the result of choose_orig() and vis_choose() is an index and therefore it
> can't be negative. Hence it is correct to make the return type unsigned
> too.
> 
> - sizeof(int) may not be the same on ALL the architectures. Since we plan
> to use choose_orig() as DHT hash function, we need to guarantee that,
> given the same argument, the result is the same. Then it is correct to
> explicitly express the size of the return type (and the second argument).
> Since the expected length is currently 4, uint32_t is the most convenient
> choice.

Applied in revision 3a0a234.

Thanks,
Marek
