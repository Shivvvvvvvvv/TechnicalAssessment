﻿using TA.TopUp.Core.Entities;
using TA.TopUp.Core.Interfaces.Repositories;
using TA.TopUp.Infrastructure.DataAccessAbstractions;

namespace TA.TopUp.Infrastructure.Repositories
{
    public class UserTransactionsRepository : GenericRepository<UserTransaction>, IUserTransactionsRepository
    {
        public UserTransactionsRepository(TopUpSystemDbContext context) : base(context) { }
    }
}
