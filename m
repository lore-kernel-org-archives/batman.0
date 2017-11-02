Return-Path: <carlitonueno@gmail.com>
MIME-Version: 1.0
From: Carlito Nueno <carlitonueno@gmail.com>
Date: Wed, 1 Nov 2017 20:07:52 -0700
Message-ID: <CAEUauspRyThs6WLqp3E2=7pHG=emT9F9eckfEWsBUwvnktaiPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] Set preferred mesh backhaul link
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

Hi,

I have two access points with 2.4GHz and 5GHz radios.

Node A and Node B

Both radios are mesh via batman-adv. I can see them with batctl if.

Node A is server - batctl gw server
Node B is client

So here is my problem:

When I check batctl gwl, it shows that it uses Node A's 2.4GHz
interface. How can I set it so that it prefers 5GHz as mesh backhaul?

Thanks!
