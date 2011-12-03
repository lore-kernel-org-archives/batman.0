Return-Path: <martin@hundeboll.net>
Message-ID: <4EDA42B2.8070104@hundeboll.net>
Date: Sat, 03 Dec 2011 16:39:30 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1322835344-23077-1-git-send-email-martin@hundeboll.net>
	<1322836747-25204-1-git-send-email-martin@hundeboll.net>
	<201112031527.51151.lindner_marek@yahoo.de>
In-Reply-To: <201112031527.51151.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Rm trailing whitespace from
 is_my_mac() in main.c
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
To: b.a.t.m.a.n@lists.open-mesh.org

On 2011-12-03 08:27, Marek Lindner wrote:
> I don't have a trailing whitespace space there and you are removing an entire
> (empty) line. Not just a whitespace ?

Yes, sorry. The commit should say "empty line" instead of "whitespace". The empty line is also present on git.open-mesh.org:
http://git.open-mesh.org/?p=batman-adv.git;a=blob;f=main.c;h=fb87bdc2ce9bdba9b551f90fcdcada42fdc594a4;hb=refs/heads/master#l173

> My checkpatch also does not complain about your first patch. Where did you get
> your checkpatch from ?

Downloaded it from git.kernel.org:
http://git.kernel.org/?p=linux/kernel/git/apw/checkpatch.git;a=blob;f=scripts/checkpatch.pl;h=e29eeea86388d88d7c878383186318632ddac6eb;hb=HEAD

Also tried to download the file from 3.1-tagged tree, which make the same complaints as I mentioned on IRC:
Patch: http://dpaste.com/664910/
checkpatch.pl complaints: http://paste.pocoo.org/show/515753/

I will make a patch v2 with a corrected commit message.

-- 
Kind regards
Martin Hundebøll

+45 61 65 54 61
martin@hundeboll.net

Nordborggade 57, 2. tv
8000 Aarhus C
Denmark
