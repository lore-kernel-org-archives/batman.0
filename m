Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 1 Nov 2011 11:08:47 +0100
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<1320015072-10313-12-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320015072-10313-12-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Message-Id: <201111011108.48015.lindner_marek@yahoo.de>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFC 11/11] [RFC] batman-adv: get primaries
	address through bat_priv->own_orig
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

On Sunday, October 30, 2011 23:51:12 Simon Wunderlich wrote:
> Instead of acquiring the first interfaces originator through
> hard interface (including referencing/dereferencing), we can use the
> cached value in bat_priv->own_orig.
> 
> There might be some cases where this function was implicitly used to
> check whether there is a hard interface configured at all (i.e. if
> batman is active), therfore this is patch is an RFC.

Most of the functions do not simply retrieve the addr but also check if there 
is a primary interface. So, what happens if batman-adv has no primary_if ? 
AFAIK that can occur if all added hard-interfaces are down.

What happens with BLAII if there is no primary interface ?

Cheers,
Marek
