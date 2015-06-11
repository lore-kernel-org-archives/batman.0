Return-Path: <xerofoify@gmail.com>
In-Reply-To: <55792240.7040301@meshcoding.com>
References: <1433989533-30587-1-git-send-email-xerofoify@gmail.com>
 <55792240.7040301@meshcoding.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
From: Nicholas Krause <xerofoify@gmail.com>
Date: Thu, 11 Jun 2015 09:17:40 -0400
Message-ID: <F9973545-FC13-4CDA-BF9E-F802B4876697@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv:Make the function
	batadv_is_my_mac bool
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
Cc: mareklindner@neomailbox.ch, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, davem@davemloft.net



On June 11, 2015 1:53:04 AM EDT, Antonio Quartulli <antonio@meshcoding.com> wrote:
>Nicholas,
>
>On 11/06/15 04:25, Nicholas Krause wrote:
>> This makes the function batadv_is_my_mac bool now due
>> to this particular function only returning either one
>> or zero as its return value.
>> 
>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>
>NAK.
>
>we already have ("batman-adv: main, Convert is_my_mac() to bool") in
>net-next that does exactly the same. I guess you did not pull the
>latest
>changes before writing this patch?
>
>Cheers,
I was basing this patch off Linux's tree, 
that's why. 
Nick 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
