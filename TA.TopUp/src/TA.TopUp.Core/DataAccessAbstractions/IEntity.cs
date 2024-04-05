namespace TA.TopUp.Core.DataAccessAbstractions
{
    public interface IEntity<T> where T : struct
    {
        T Id { get; protected set; }

    }

    public interface IEntity : IEntity<Guid> { }
}
