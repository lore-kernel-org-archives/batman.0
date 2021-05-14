Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3 2/2] batctl: debug: Introduce handler for DEBUGJSON
Date: Fri, 14 May 2021 18:15:59 +0200
Message-ID: <5981466.ZLWtV3aTVX@sven-desktop>
In-Reply-To: <20210513141034.1649576-3-asarmanow@gmail.com>
References: <20210513141034.1649576-1-asarmanow@gmail.com> <20210513141034.1649576-3-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Thursday, 13 May 2021 16:10:34 CEST Alexander Sarmanow wrote:
> DEBUGJSON commands require an own handler, since they may have their own
> parameters. So far there is currently only the help parameter, but more can be
> added in future.
> 
> Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
> ---
>  debug.c | 29 +++++++++++++++++++++++++++++
>  debug.h |  5 +++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/debug.c b/debug.c
> index 458c137..20467c7 100644
> --- a/debug.c
> +++ b/debug.c

These commands are not for debug tables and would better fit in the the 
genl_json file (or something similar).

And a lot of functionality is missing here. You basically duplicated the same 
function in the actual neighbors_json, originators_json, transglobal_json and 
translocal_json files. Stuff which could have been handled globally for the 
netlink queries with JSON output.

Kind regards,
	Sven

