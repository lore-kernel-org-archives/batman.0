Return-Path: <yuzhe@nfschina.com>
Message-ID: <e4525347-f3b1-440c-b72b-4b7a6830a0d1@nfschina.com>
Date: Tue, 26 Apr 2022 17:52:19 +0800
MIME-Version: 1.0
From: yuzhe <yuzhe@nfschina.com>
Subject: Re: [PATCH] batman-adv: remove unnecessary type castings
References: <20220421154829.9775-1-yuzhe@nfschina.com>
 <20220425113635.1609532-1-yuzhe@nfschina.com> <2133162.nbW41nx31j@ripper>
In-Reply-To: <2133162.nbW41nx31j@ripper>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, liqiong@nfschina.com, kernel-janitors@vger.kernel.org

I agree, this patch is better. And I have tested, no sparse warning anymore.

Thank your for your help.

       

在 2022/4/25 20:50, Sven Eckelmann 写道:

     

>        
> On Monday, 25 April 2022 13:36:35 CEST Yu Zhe wrote:
>        
>>          
>> remove unnecessary void* type castings.
>>
>> Signed-off-by: Yu Zhe<yuzhe@nfschina.com>
>> ---
>>   net/batman-adv/translation-table.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>        
>        
> If you send a second version then please use `git format-patch -v2 ...` to
> format the patch. Now it looks in patchworks like you've resent the first
> version again. And please also add a little changelog after "---" which
> explains what you've changed. It is trivial in this little patch but still
> might be useful.
>
> Regarding the patch: Now you've removed bridge_loop_avoidance.c +
> batadv_choose_tt instead of fixing your patch. I would really prefer this
> patch version:
>
> https://git.open-mesh.org/linux-merge.git/commitdiff/8864d2fcf04385cabb8c8bb159f1f2ba5790cf71
>
> Kind regards,
> 	Sven
>      
