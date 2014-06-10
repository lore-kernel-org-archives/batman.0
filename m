Return-Path: <gaul@web-yard.de>
Message-ID: <5397267F.4040107@web-yard.de>
Date: Tue, 10 Jun 2014 17:38:39 +0200
From: =?UTF-8?B?QW5kcsOpIEdhdWw=?= <gaul@web-yard.de>
MIME-Version: 1.0
References: <53957653.5000406@meshcoding.com>
 <1402334059-28681-1-git-send-email-gaul@web-yard.de>
 <53962199.4060202@meshcoding.com> <539628F6.9070706@web-yard.de>
 <53969F3D.5040306@meshcoding.com>
In-Reply-To: <53969F3D.5040306@meshcoding.com>
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

Hi Antonio!

Am 10.06.2014 08:01, schrieb Antonio Quartulli:
> maybe it's the mail client that messes the patch up? Are you using
> git-send-email ?

Yep, it's git-send-email. Maybe you are running into this mbox/eml issue
[1]? Thunderbird seems to save plain text files with DOS line endings
when saved as .eml. I can reproduce the errors you got with an .eml
file. When saving as .txt it has the correct line endings and the
checkpatch script gives no errors or warnings.

If this resolves the issue with the DOS line endings, I'd resubmit with
the corrected subject line.


Cheers,
André


[1] https://bugzilla.mozilla.org/show_bug.cgi?id=523577

-- 
Homepage   http://page.math.tu-berlin.de/~gaul
github     https://github.com/andrenarchy
Twitter    https://twitter.com/#!/andrenarchy
Diaspora   https://diasp.org/u/andrenarchy
           (you won't find me on facebook!)
Jabber     gaul@web-yard.de
PGP Key    0x0FA9170E
