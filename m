Return-Path: <russell@personaltelco.net>
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
From: Russell Senior <russell@personaltelco.net>
Date: Tue, 21 Jan 2014 10:43:29 -0800
In-Reply-To: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
 (Antonio Quartulli's message of "Tue\, 21 Jan 2014 11\:22\:05 +0100")
Message-ID: <86mwipch0u.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix soft-interface MTU
	computation
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Antonio Quartulli <antonio@meshcoding.com>

>>>>> "Antonio" == Antonio Quartulli <antonio@meshcoding.com> writes:

Antonio> The current MTU computation always returns a value smaller
Antonio> than 1500bytes even if the real interfaces have an MTU large
Antonio> enough to compensate the batman-adv overhead.

Antonio> Fix the computation by properly returning the highest
Antonio> admitted value.

Antonio> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com> ---

This seems to fix the bat0-MTU-unnecessarily-small problem I observed
last night and reported on the IRC channel.  I haven't actually passed
any traffic over it yet, but the interface is up with the expected MTU
value with the patch.

Antonio> This patch is missing a Reported-by clause because I did not
Antonio> have "russell"'s email address at hand.

Antonio> Will be added later before being merged.

Reported-by: Russell Senior <russell@personaltelco.net>


-- 
Russell Senior, President
russell@personaltelco.net
