Return-Path: <martin@hundeboll.net>
Message-ID: <4EDA4332.6080706@hundeboll.net>
Date: Sat, 03 Dec 2011 16:41:38 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1322835344-23077-1-git-send-email-martin@hundeboll.net>
	<1322836651-25134-1-git-send-email-martin@hundeboll.net>
	<201112031536.26477.lindner_marek@yahoo.de>
In-Reply-To: <201112031536.26477.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Move is_out_of_time() to
 main.c for general use
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

On 2011-12-03 08:36, Marek Lindner wrote:
> Since it is a simple one-liner you could make it a define or at least static
> inline (in main.h).

Correct. Maybe the correct solution is to remove the function and just call time_is_before_jiffies() directly instead?

-- 
Kind regards
Martin Hundebøll

+45 61 65 54 61
martin@hundeboll.net

Nordborggade 57, 2. tv
8000 Aarhus C
Denmark
