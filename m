Return-Path: <martin@hundeboll.net>
Date: Mon, 13 Aug 2012 16:22:26 +0200
From: Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@hundeboll.net>
Message-ID: <20120813162226.78e1b8ac@hundeboll.net>
In-Reply-To: <1344867287.41025.YahooMailClassic@web162705.mail.bf1.yahoo.com>
References: <1344867287.41025.YahooMailClassic@web162705.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] difficulty with audio packets
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Adam,

On Mon, 13 Aug 2012 07:14:47 -0700 (PDT)
adam wiz <gibsonsg91921@yahoo.com> wrote:

> I am having a strange issue with my mesh. I have four access points
> running Batman-advanced and it works well when testing simple Python
> socket programming scripts with Android phones connected to separate
> access points. However, when I try to send audio packets, it won't
> work to the same success. My test Android app has the recipient
> device's IP address hardcoded. The recipient phone can successfully
> call itself, but the other phone connected to a different access
> point can't call the destination. The buffer size is 2048 bytes. Is
> this too large a buffer? What would cause this problem?

You should try to follow the packets with "batctl -m bat0 td" and
"tcpdump -i wlan0" and see if they actually make into and through the
mesh.

// Martin
