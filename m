Return-Path: <gaul@web-yard.de>
Message-ID: <539628F6.9070706@web-yard.de>
Date: Mon, 09 Jun 2014 23:36:54 +0200
From: =?UTF-8?B?QW5kcsOpIEdhdWw=?= <gaul@web-yard.de>
MIME-Version: 1.0
References: <53957653.5000406@meshcoding.com>
 <1402334059-28681-1-git-send-email-gaul@web-yard.de>
 <53962199.4060202@meshcoding.com>
In-Reply-To: <53962199.4060202@meshcoding.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] remove unnecessary logspam
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hey Antonio,

thx for your quick reply!

Am 09.06.2014 23:05, schrieb Antonio Quartulli:
> I'd suggest you to check this patch with checkpatch.pl --strict. Here I
> get many errors due to non-printable chars at the end of various lines.

I did that and I don't get any errors or warnings with checkpatch.pl
--strict. It tells me:

------
$ ./scripts/checkpatch.pl --strict
/tmp/0001-remove-unnecessary-logspam.patch
total: 0 errors, 0 warnings, 65 lines checked

/tmp/0001-remove-unnecessary-logspam.patch has no obvious style problems
and is ready for submission.
------

> Here[1] you find our guidelines (which is a set of complementary rules
> to the guidelines you find in the kernel tree[2]).
> 
> Moreover, the subject must start with "batman-adv: ", because this patch
> will end up in the kernel and it requires this format to easily
> distinguish the subsystem that the patch is touching.
> 
> A couple of things to keep in mind while sending new versions of the
> same patch:
> - don't reply to an existing thread
> - write [PATCHvN] (with N = version of the patch - 2 in this case) in
> the subject

OK, I can resubmit with the corrected subject line
  [PATCHv2] batman-adv: remove unnecessary logspam
but I'd like to know first what this non-printable chars issue is about.

cheers,
André

-- 
Homepage   http://page.math.tu-berlin.de/~gaul
github     https://github.com/andrenarchy
Twitter    https://twitter.com/#!/andrenarchy
Diaspora   https://diasp.org/u/andrenarchy
           (you won't find me on facebook!)
Jabber     gaul@web-yard.de
PGP Key    0x0FA9170E
