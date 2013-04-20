Return-Path: <martin@hundeboll.net>
Message-ID: <51729FC5.2080608@hundeboll.net>
Date: Sat, 20 Apr 2013 16:01:41 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1366280099-6372-1-git-send-email-martin@hundeboll.net>
 <1366373804-26785-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1366373804-26785-1-git-send-email-martin@hundeboll.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: Move call to
 batadv_nc_skb_forward() from routing.c to send.c
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

On 2013-04-19 14:16, Martin Hundebøll wrote:
> The call to batadv_nc_skb_forward() fits better in
> batadv_send_skb_to_orig(), as this is where the actual next hop is
> looked up.
>
> Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
> ---
>
> v2: I should make random defines lowercase :)
> v3: Do git add before committing and sending patches :|
> v4: Don't count non-coded packets twice
>
> network-coding.c | 8 ++------
>   network-coding.h | 6 ++----
>   routing.c        | 9 +++------
>   send.c           | 9 +++++++--
>   4 files changed, 14 insertions(+), 18 deletions(-)


Okay, I include this patch as a part of the fragmentation series, as 
this is why it is needed.


-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
