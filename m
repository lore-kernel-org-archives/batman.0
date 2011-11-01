Return-Path: <ordex@autistici.org>
Date: Tue, 1 Nov 2011 14:43:49 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111101134348.GH20215@ritirata.org>
References: <1320001741-18351-1-git-send-email-ordex@autistici.org>
	<20111031004201.GH10726@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20111031004201.GH10726@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: generalise
 tt_local_reset_flags()
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

On Mon, Oct 31, 2011 at 01:42:01AM +0100, Simon Wunderlich wrote:
> Hey Antonio,
> 
> I don't quite understand what this patch is good for - it generalises the function,
> but does not use the function at another point. So what it is good for (next to
> add more complexity to batman ;] ).
> 
> Furthermore it counts the changes and adds it to num_local_tt, is there a bug fix
> hidden in this patch somewhere? :)

No hidden bug-fix here :)
This patch aims to generalise the tt_local_reset_flags() function only. As I
discussed with Sven on IRC, this function could be quite confusing, because its
name suggests that it can be used either for other purposes, but this is not
true: it can only be used as it is now in the code.

Therefore this patch wants to generalise it enough in order to be eventually
used elsewhere.

The increment of tt_local_num is actually done inside the function and it is
useful only for the use case proposed in the current code. To generalise the
function I had to move the increment outside (somebody else could want to flip a
certain flag without affecting the local counter :-) ).

IMHO this patch is not strictly needed, but it would clean the code up (Until
it doesn't add any complexity :P)

Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
