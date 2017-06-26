Return-Path: <colin.king@canonical.com>
References: <20170625215607.30401-1-colin.king@canonical.com>
 <ade9a7c5-6956-d614-afcc-5476070d025e@cogentembedded.com>
 <fdaf388e-c2a4-bf3e-4b7e-a1169c72d9e4@cogentembedded.com>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <e2983c06-1183-56f8-c318-97445ed6d8b9@canonical.com>
Date: Mon, 26 Jun 2017 11:05:10 +0100
MIME-Version: 1.0
In-Reply-To: <fdaf388e-c2a4-bf3e-4b7e-a1169c72d9e4@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix spelling mistake
 "ourselve" -> "ourself"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S . Miller" <davem@davemloft.net>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On 26/06/17 11:02, Sergei Shtylyov wrote:
> On 6/26/2017 1:01 PM, Sergei Shtylyov wrote:
> 
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Trivial fix to spelling mistake in batadv_dbg debug message
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>   net/batman-adv/bat_v_ogm.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
>>> index 1e3dc374bfde..d6dbf67acbb5 100644
>>> --- a/net/batman-adv/bat_v_ogm.c
>>> +++ b/net/batman-adv/bat_v_ogm.c
>>> @@ -200,7 +200,7 @@ static void batadv_v_ogm_send(struct work_struct
>>> *work)
>>>                   type = "unknown";
>>>               }
>>> -            batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 from
>>> ourselve on %s surpressed: %s\n",
>>> +            batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 from
>>> ourself on %s surpressed: %s\n",
>>
>>     I think proper English is "ourselves"...
> 
>    Sorry. "ourself" also seems valid. :-)
> 
>> [...]
> 
> MBR, Sergei

Yep, my bad grammar fail. I'll resend with some extra fixes.
