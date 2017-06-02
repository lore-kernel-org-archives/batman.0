Return-Path: <xbing6@gmail.com>
References: <f353223e-4902-6eba-c655-36d46d07c892@gmail.com>
 <7877746.ih6RbTeLZ5@bentobox>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <bc5192e1-8855-6704-0a7e-0e76ee443450@gmail.com>
Date: Fri, 2 Jun 2017 16:57:03 +0800
MIME-Version: 1.0
In-Reply-To: <7877746.ih6RbTeLZ5@bentobox>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [B.A.T.M.A.N.] [batman-adv] one edge case with 40+ neighbors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org

Hi Sven,

Thanks for asking this. It is my fault that I did not ask our QA and 
tell the community the details.

The syndrome is that there are randomly nodes that can not ping other 
nodes, it happens quite often within a day. As I changed ath_dbg() to 
ath_warn() to print messages before ath9k_queue_reset() in our release, 
we get "tx hung, resetting the chip" in dmesg (for RESET_TYPE_TX_HANG).
-- I am using software encryption.

This seems pointing to that ath9k driver can not handle 40 connections 
for IBSS/adhoc? Based on our test, 20 connections for ath9k IBSS/adhoc 
are definitely ok.

Thanks.
Xuebing Wang


On 2017年06月02日 15:04, Sven Eckelmann wrote:
> On Freitag, 2. Juni 2017 14:57:18 CEST Xuebing Wang wrote:
>>   And batman-adv seemingly does not work for this edge
> Please define "does not work" in your setup.
>
> Kind regards,
> 	Sven

