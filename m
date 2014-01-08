Return-Path: <dingtianhong@huawei.com>
Message-ID: <52CCFEFB.201@huawei.com>
Date: Wed, 8 Jan 2014 15:32:11 +0800
From: Ding Tianhong <dingtianhong@huawei.com>
MIME-Version: 1.0
References: <52CCBDA9.8090205@huawei.com> <52CCF906.7000400@meshcoding.com>
In-Reply-To: <52CCF906.7000400@meshcoding.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH v3.6 06/19] batman-adv: use
 batadv_compare_eth for concise
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
To: Antonio Quartulli <antonio@meshcoding.com>, The list for a Better
 Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, "David S. Miller" <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2014/1/8 15:06, Antonio Quartulli wrote:
> On 08/01/14 03:53, Ding Tianhong wrote:
>> It is better to use batadv_compate_eth instead of memcpy for
>> concise style.
>>
>> Cc: Marek Lindner <mareklindner@neomailbox.ch>
>> Cc: Simon Wunderlich <sw@simonwunderlich.de>
>> Cc: Antonio Quartulli <antonio@meshcoding.com>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: b.a.t.m.a.n@lists.open-mesh.org
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>> Acked-by: Antonio Quartulli <antonio@meshcoding.com>
> 
> Am I wrong or this patch has already been merged in net-next (together
> with other patches from this series)?
> 
> 
> 
> Regards,
> 
> 
Yes， it is already in net-next, so miss it, thanks.

Regards
Ding

