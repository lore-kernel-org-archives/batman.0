Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: Problems with Multiple Interfaces
From: joe@careyhome.org
Date: Sat, 10 Apr 2021 00:39:53 -0000
Message-ID: <20210410003953.1234.9147@diktynna.open-mesh.org>
In-Reply-To: <3542676.qYy7ulQ77K@prime>
References: <3542676.qYy7ulQ77K@prime>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Linus and Simon,

Thank you for your responses.

I did try "batctl ping" and the adjacent device was unreachable.  I could see it with "batctl n". I did not try a simple IPv6 link local ping.  However, I could see it using "iw dev mesh_5g station dump"

I agree that it feels like a problem with ath10k reporting the data rate incorrectly (or not at all).

I am going to try upgrading to the latest release, but it will be a few days.  I'll let you know how it goes.

Thanks again,

--Joe
