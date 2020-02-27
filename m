Return-Path: <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] batman-adv: Replace zero-length array with
 flexible-array member
References: <20200217214300.GA14129@embeddedor> <10763787.LixBgDfVEo@sven-edge>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ba787bf4-1b9b-1b1c-97b0-253ea2329d0d@embeddedor.com>
Date: Thu, 27 Feb 2020 14:06:56 -0600
MIME-Version: 1.0
In-Reply-To: <10763787.LixBgDfVEo@sven-edge>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org



On 2/17/20 15:49, Sven Eckelmann wrote:

>>
>> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>> [2] https://github.com/KSPP/linux/issues/21
>> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  net/batman-adv/distributed-arp-table.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied
> 

Thanks, Sven.
--
Gustavo
